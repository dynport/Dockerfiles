#!/usr/bin/env ruby
require "net/http"
require "json"
require 'logger'

DAY = 24 * 3600
MAX_AGE = ENV.fetch("MAX_AGE", 14).to_i * DAY
IMAGE_PREFIX = ENV.fetch("IMAGE_PREFIX")
LOGGER = Logger.new(STDOUT)
NONE_IMAGE = "<none>:<none>"

raise "MAX_AGE must not be 0" if MAX_AGE == 0

def main
  cleanup_containers
  cleanup_images
end

def cleanup_containers
  containers = load_containers
  LOGGER.info "loaded %d containers" % [containers.count]
  to_delete = []
  containers.each do |c|
    if c.exited? && (Time.now - c.created_at) >= MAX_AGE
      to_delete << c.id
    end
  end
  LOGGER.info "about to delete %d containers" % [to_delete.count]
  to_delete.each do |id|
    LOGGER.info "deleting container #{id}"
    delete_container(id)
  end
end

def delete_container(id)
  system "curl --unix-socker /var/run/docker.sock -X DELETE http://127.0.0.1:4243/containers/#{id}"
end

def load_containers
  load_json("http://127.0.0.1:4243/containers/json").map { |atts| Container.new(atts) }
end

class Container
  def initialize(atts)
    @atts = atts
  end

  def id
    @atts.fetch("Id")
  end

  def created_at
    Time.at(@atts.fetch("Created"))
  end

  def exited?
    status.start_with?("Exited ")
  end

  def status
    @atts.fetch("Status")
  end
end

def cleanup_images
  images = load_images

  LOGGER.info "loaded %d images" % [images.count]

  filtered = filter_images(images, image_prefix: IMAGE_PREFIX, max_age: MAX_AGE).sort_by(&:created_at)

  to_delete = []
  filtered.each do |img|
    if none_image(img)
      to_delete << img.id
    else
      to_delete += img.repo_tags
    end
  end

  LOGGER.info "about to delete %d images" % [to_delete.count]

  to_delete.each do |tag|
    LOGGER.info "delete image #{tag}"
    delete_image tag
  end
end

def delete_image(tag_or_id)
  system "curl --unix-socker /var/run/docker.sock -X DELETE http://127.0.0.1:4243/images/#{tag_or_id}"
end

def get(url)
  res = `curl -s --unix-socket /var/run/docker.sock #{url} 2>&1`
  raise "error fetching url #{url}: #{res}" unless $?.success?
  res
end

def load_json(url)
  JSON.load(get(url))
end

def load_images
  load_json("http://127.0.0.1:4243/images/json").map { |atts| Image.new(atts) }
end

def filter_images(images, max_age:, image_prefix:)
  images.select do |img|
    if !img.repo_tags.empty?
      (none_image(img) || img.repo_tags.first.start_with?(image_prefix) && (Time.now - img.created_at >= max_age))
    else
      false
    end
  end
end

def none_image(img)
  img.repo_tags.length == 1 && img.repo_tags.first == NONE_IMAGE
end

class Image
  def initialize(atts)
    @atts = atts
  end

  def repo_tags
    @atts.fetch("RepoTags", [])
  end

  def id
    @atts["Id"]
  end

  def created_at
    Time.at(@atts["Created"])
  end
end

main
