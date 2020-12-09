.. -*- coding: utf-8; mode: rst -*-

video.h
=======

.. parsed-literal::

    \/\* SPDX-License-Identifier\: LGPL-2.1+ WITH Linux-syscall-note \*\/
    \/\*
     \* video.h - **DEPRECATED** MPEG-TS video decoder API
     \*
     \* NOTE\: should not be used on future drivers
     \*
     \* Copyright (C) 2000 Marcus Metzler \<marcus@convergence.de\>
     \*                  \& Ralph  Metzler \<ralph@convergence.de\>
     \*                    for convergence integrated media GmbH
     \*
     \* This program is free software; you can redistribute it and\/or
     \* modify it under the terms of the GNU Lesser General Public License
     \* as published by the Free Software Foundation; either version 2.1
     \* of the License, or (at your option) any later version.
     \*
     \* This program is distributed in the hope that it will be useful,
     \* but WITHOUT ANY WARRANTY; without even the implied warranty of
     \* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     \* GNU General Public License for more details.
     \*
     \* You should have received a copy of the GNU Lesser General Public License
     \* along with this program; if not, write to the Free Software
     \* Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
     \*
     \*\/

    \#ifndef \_UAPI\_DVBVIDEO\_H\_
    \#define \_UAPI\_DVBVIDEO\_H\_

    \#include \<linux\/types.h\>
    \#ifndef \_\_KERNEL\_\_
    \#include \<time.h\>
    \#endif

    typedef enum \{
            VIDEO\_FORMAT\_4\_3,     \/\* Select 4\:3 format \*\/
            VIDEO\_FORMAT\_16\_9,    \/\* Select 16\:9 format. \*\/
            VIDEO\_FORMAT\_221\_1    \/\* 2.21\:1 \*\/
    \} video\_format\_t;

    typedef enum \{
            VIDEO\_PAN\_SCAN,       \/\* use pan and scan format \*\/
            VIDEO\_LETTER\_BOX,     \/\* use letterbox format \*\/
            VIDEO\_CENTER\_CUT\_OUT  \/\* use center cut out format \*\/
    \} video\_displayformat\_t;

    typedef struct \{
            int w;
            int h;
            video\_format\_t aspect\_ratio;
    \} video\_size\_t;

    typedef enum \{
            VIDEO\_SOURCE\_DEMUX, \/\* Select the demux as the main source \*\/
            VIDEO\_SOURCE\_MEMORY \/\* If this source is selected, the stream
                                   comes from the user through the write
                                   system call \*\/
    \} video\_stream\_source\_t;

    typedef enum \{
            VIDEO\_STOPPED, \/\* Video is stopped \*\/
            VIDEO\_PLAYING, \/\* Video is currently playing \*\/
            VIDEO\_FREEZED  \/\* Video is freezed \*\/
    \} video\_play\_state\_t;

    \/\* Decoder commands \*\/
    \#define VIDEO\_CMD\_PLAY        (0)
    \#define VIDEO\_CMD\_STOP        (1)
    \#define VIDEO\_CMD\_FREEZE      (2)
    \#define VIDEO\_CMD\_CONTINUE    (3)

    \/\* Flags for VIDEO\_CMD\_FREEZE \*\/
    \#define VIDEO\_CMD\_FREEZE\_TO\_BLACK       (1 \<\< 0)

    \/\* Flags for VIDEO\_CMD\_STOP \*\/
    \#define VIDEO\_CMD\_STOP\_TO\_BLACK         (1 \<\< 0)
    \#define VIDEO\_CMD\_STOP\_IMMEDIATELY      (1 \<\< 1)

    \/\* Play input formats\: \*\/
    \/\* The decoder has no special format requirements \*\/
    \#define VIDEO\_PLAY\_FMT\_NONE         (0)
    \/\* The decoder requires full GOPs \*\/
    \#define VIDEO\_PLAY\_FMT\_GOP          (1)

    \/\* The structure must be zeroed before use by the application
       This ensures it can be extended safely in the future. \*\/
    struct video_command \{
            \_\_u32 cmd;
            \_\_u32 flags;
            union \{
                    struct \{
                            \_\_u64 pts;
                    \} stop;

                    struct \{
                            \/\* 0 or 1000 specifies normal speed,
                               1 specifies forward single stepping,
                               -1 specifies backward single stepping,
                               \>1\: playback at speed\/1000 of the normal speed,
                               \<-1\: reverse playback at (-speed\/1000) of the normal speed. \*\/
                            \_\_s32 speed;
                            \_\_u32 format;
                    \} play;

                    struct \{
                            \_\_u32 data[16];
                    \} raw;
            \};
    \};

    \/\* FIELD\_UNKNOWN can be used if the hardware does not know whether
       the Vsync is for an odd, even or progressive (i.e. non-interlaced)
       field. \*\/
    \#define VIDEO\_VSYNC\_FIELD\_UNKNOWN       (0)
    \#define VIDEO\_VSYNC\_FIELD\_ODD           (1)
    \#define VIDEO\_VSYNC\_FIELD\_EVEN          (2)
    \#define VIDEO\_VSYNC\_FIELD\_PROGRESSIVE   (3)

    struct video_event \{
            \_\_s32 type;
    \#define VIDEO\_EVENT\_SIZE\_CHANGED        1
    \#define VIDEO\_EVENT\_FRAME\_RATE\_CHANGED  2
    \#define VIDEO\_EVENT\_DECODER\_STOPPED     3
    \#define VIDEO\_EVENT\_VSYNC               4
            \/\* unused, make sure to use atomic time for y2038 if it ever gets used \*\/
            long timestamp;
            union \{
                    video\_size\_t size;
                    unsigned int frame\_rate;        \/\* in frames per 1000sec \*\/
                    unsigned char vsync\_field;      \/\* unknown\/odd\/even\/progressive \*\/
            \} u;
    \};

    struct video_status \{
            int                   video\_blank;   \/\* blank video on freeze? \*\/
            video\_play\_state\_t    play\_state;    \/\* current state of playback \*\/
            video\_stream\_source\_t stream\_source; \/\* current source (demux\/memory) \*\/
            video\_format\_t        video\_format;  \/\* current aspect ratio of stream\*\/
            video\_displayformat\_t display\_format;\/\* selected cropping mode \*\/
    \};

    struct video_still_picture \{
            char \_\_user \*iFrame;        \/\* pointer to a single iframe in memory \*\/
            \_\_s32 size;
    \};

    typedef \_\_u16 video\_attributes\_t;
    \/\*   bits\: descr. \*\/
    \/\*   15-14 Video compression mode (0=MPEG-1, 1=MPEG-2) \*\/
    \/\*   13-12 TV system (0=525\/60, 1=625\/50) \*\/
    \/\*   11-10 Aspect ratio (0=4\:3, 3=16\:9) \*\/
    \/\*    9- 8 permitted display mode on 4\:3 monitor (0=both, 1=only pan-sca \*\/
    \/\*    7    line 21-1 data present in GOP (1=yes, 0=no) \*\/
    \/\*    6    line 21-2 data present in GOP (1=yes, 0=no) \*\/
    \/\*    5- 3 source resolution (0=720x480\/576, 1=704x480\/576, 2=352x480\/57 \*\/
    \/\*    2    source letterboxed (1=yes, 0=no) \*\/
    \/\*    0    film\/camera mode (0=
     \*camera, 1=film (625\/50 only)) \*\/

    \/\* bit definitions for capabilities\: \*\/
    \/\* can the hardware decode MPEG1 and\/or MPEG2? \*\/
    \#define VIDEO\_CAP\_MPEG1   1
    \#define VIDEO\_CAP\_MPEG2   2
    \/\* can you send a system and\/or program stream to video device?
       (you still have to open the video and the audio device but only
        send the stream to the video device) \*\/
    \#define VIDEO\_CAP\_SYS     4
    \#define VIDEO\_CAP\_PROG    8
    \/\* can the driver also handle SPU, NAVI and CSS encoded data?
       (CSS API is not present yet) \*\/
    \#define VIDEO\_CAP\_SPU    16
    \#define VIDEO\_CAP\_NAVI   32
    \#define VIDEO\_CAP\_CSS    64

    \#define \ :ref:`VIDEO_STOP <video_stop>`                 \_IO('o', 21)
    \#define \ :ref:`VIDEO_PLAY <video_play>`                 \_IO('o', 22)
    \#define \ :ref:`VIDEO_FREEZE <video_freeze>`               \_IO('o', 23)
    \#define \ :ref:`VIDEO_CONTINUE <video_continue>`             \_IO('o', 24)
    \#define \ :ref:`VIDEO_SELECT_SOURCE <video_select_source>`        \_IO('o', 25)
    \#define \ :ref:`VIDEO_SET_BLANK <video_set_blank>`            \_IO('o', 26)
    \#define \ :ref:`VIDEO_GET_STATUS <video_get_status>`           \_IOR('o', 27, struct video_status\ )
    \#define \ :ref:`VIDEO_GET_EVENT <video_get_event>`            \_IOR('o', 28, struct video_event\ )
    \#define \ :ref:`VIDEO_SET_DISPLAY_FORMAT <video_set_display_format>`   \_IO('o', 29)
    \#define \ :ref:`VIDEO_STILLPICTURE <video_stillpicture>`         \_IOW('o', 30, struct video_still_picture\ )
    \#define \ :ref:`VIDEO_FAST_FORWARD <video_fast_forward>`         \_IO('o', 31)
    \#define \ :ref:`VIDEO_SLOWMOTION <video_slowmotion>`           \_IO('o', 32)
    \#define \ :ref:`VIDEO_GET_CAPABILITIES <video_get_capabilities>`     \_IOR('o', 33, unsigned int)
    \#define \ :ref:`VIDEO_CLEAR_BUFFER <video_clear_buffer>`         \_IO('o',  34)
    \#define \ :ref:`VIDEO_SET_STREAMTYPE <video_set_streamtype>`       \_IO('o', 36)
    \#define \ :ref:`VIDEO_SET_FORMAT <video_set_format>`           \_IO('o', 37)
    \#define \ :ref:`VIDEO_GET_SIZE <video_get_size>`             \_IOR('o', 55, video\_size\_t)

    \/\*\*
     \* \ :ref:`VIDEO_GET_PTS <video_get_pts>`
     \*
     \* Read the 33 bit presentation time stamp as defined
     \* in ITU T-REC-H.222.0 \/ ISO\/IEC 13818-1.
     \*
     \* The PTS should belong to the currently played
     \* frame if possible, but may also be a value close to it
     \* like the PTS of the last decoded frame or the last PTS
     \* extracted by the PES parser.
     \*\/
    \#define \ :ref:`VIDEO_GET_PTS <video_get_pts>`              \_IOR('o', 57, \_\_u64)

    \/\* Read the number of displayed frames since the decoder was started \*\/
    \#define \ :ref:`VIDEO_GET_FRAME_COUNT <video_get_frame_count>`      \_IOR('o', 58, \_\_u64)

    \#define \ :ref:`VIDEO_COMMAND <video_command>`              \_IOWR('o', 59, struct video_command\ )
    \#define \ :ref:`VIDEO_TRY_COMMAND <video_try_command>`          \_IOWR('o', 60, struct video_command\ )

    \#endif \/\* \_UAPI\_DVBVIDEO\_H\_ \*\/
