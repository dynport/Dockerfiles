from __future__ import print_function
import time
import pychromecast

dashboard = 'Dynasty_Dashboard'
chromecasts = pychromecast.get_chromecasts()

print("loaded casts")
cast = next(cc for cc in chromecasts if cc.device.friendly_name == dashboard)
cast.wait()

mediaType = 'video/webm'
url = 'http://192.168.1.28:31872/dashboard.webm'
url = 'http://macmini.office.phraseapp.io/dashboard.webm'
mc = cast.media_controller
mc.play_media(url, mediaType)
mc.block_until_active()
print(mc.status)
mc.pause()
time.sleep(5)
mc.play()
