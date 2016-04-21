# ipTV - ita
Simple IPTV streaming app for **iOS** (universal target) and **Mac OSX**.  
Based on a googled (non pay-tv) italian channel list.


##iOS
###Channel list
![Chat](ss1.png)
![Chat](ss2.png)
  
###Live streaming
![Chat](ss3.png)

##OSx
###Channel list
![Chat](ss4.png)
![Chat](ss5.png)

In **OSX** the player is *QuickTime*.

---

###Playlist format
	[...]
	#EXTINF:0,Italia 1 HD
	http://live3.msf.ticdn.it/Content/HLS/Live/Channel(CH02HA)/Stream(04)/index.m3u8
	[...]
	
###Playlist url
[https://dl.dropboxusercontent.com/u/11796049/piStream/tv-ita.m3u]()

---

###Used pods

	pod "VKVideoPlayer", "~> 0.1.1"
	pod 'AFNetworking', '~> 3.1'
	pod 'MCSwipeTableViewCell', '~> 2.1'

###Requirements
- ARC
- iOS 8.1+

---

###TODO
- Remove broken links from table (swipe cell).
- Integrate a native player in the OSX app.

###Known issues
- Nothing interesting. It's a one shot project.

---

**Have fun.**