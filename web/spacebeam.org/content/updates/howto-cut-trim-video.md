title: How to Cut and Trim Video
date: 2021-12-10
description: How Does FFmpeg Trim Videos
tags: guide 

The following command is used to trim video in FFmpeg. The stream copy enables to trim video without re-encoding and meanwhile keeps original quality for the output video.

```
:::bash
ffmpeg -i input.mp4 -ss 00:01:23 -to 00:04:20 -c copy output.mp4 
```

-c copy trim via stream copy, which is fast and will not re-encode video.
