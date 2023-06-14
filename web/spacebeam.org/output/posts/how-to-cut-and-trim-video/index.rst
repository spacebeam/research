---
category: ''
date: 2021-03-03 19:02:09 UTC-06:00
description: ''
link: ''
slug: how-to-cut-and-trim-video
tags: 'ffmpeg, guide'
title: How To Cut and Trim Video
type: text
---
The following command is used to trim video in FFmpeg. The stream copy enables to trim video without re-encoding and meanwhile keeps original quality for the output video.

```
.. code:: bash
ffmpeg -i input.mp4 -ss 00:01:23 -to 00:04:20 -c copy output.mp4
```

.. code:: bash
ffmpeg -i input.mp4 -ss 00:01:23 -to 00:04:20 -c copy output.mp4

-c copy trim via stream copy, which is fast and will not re-encode video.
