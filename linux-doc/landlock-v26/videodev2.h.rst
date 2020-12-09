.. -*- coding: utf-8; mode: rst -*-

videodev2.h
===========

.. parsed-literal::

    \/\* SPDX-License-Identifier\: ((GPL-2.0+ WITH Linux-syscall-note) OR BSD-3-Clause) \*\/
    \/\*
     \*  Video for Linux Two header file
     \*
     \*  Copyright (C) 1999-2012 the contributors
     \*
     \*  This program is free software; you can redistribute it and\/or modify
     \*  it under the terms of the GNU General Public License as published by
     \*  the Free Software Foundation; either version 2 of the License, or
     \*  (at your option) any later version.
     \*
     \*  This program is distributed in the hope that it will be useful,
     \*  but WITHOUT ANY WARRANTY; without even the implied warranty of
     \*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     \*  GNU General Public License for more details.
     \*
     \*  Alternatively you can redistribute this file under the terms of the
     \*  BSD license as stated below\:
     \*
     \*  Redistribution and use in source and binary forms, with or without
     \*  modification, are permitted provided that the following conditions
     \*  are met\:
     \*  1. Redistributions of source code must retain the above copyright
     \*     notice, this list of conditions and the following disclaimer.
     \*  2. Redistributions in binary form must reproduce the above copyright
     \*     notice, this list of conditions and the following disclaimer in
     \*     the documentation and\/or other materials provided with the
     \*     distribution.
     \*  3. The names of its contributors may not be used to endorse or promote
     \*     products derived from this software without specific prior written
     \*     permission.
     \*
     \*  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
     \*  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
     \*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
     \*  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
     \*  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
     \*  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
     \*  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
     \*  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
     \*  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
     \*  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
     \*  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
     \*
     \*      Header file for v4l or V4L2 drivers and applications
     \* with public API.
     \* All kernel-specific stuff were moved to media\/v4l2-dev.h, so
     \* no \#if \_\_KERNEL tests are allowed here
     \*
     \*      See https\:\/\/linuxtv.org for more info
     \*
     \*      Author\: Bill Dirks \<bill@thedirks.org\>
     \*              Justin Schoeman
     \*              Hans Verkuil \<hverkuil@xs4all.nl\>
     \*              et al.
     \*\/
    \#ifndef \_UAPI\_\_LINUX\_VIDEODEV2\_H
    \#define \_UAPI\_\_LINUX\_VIDEODEV2\_H

    \#ifndef \_\_KERNEL\_\_
    \#include \<sys\/time.h\>
    \#endif
    \#include \<linux\/compiler.h\>
    \#include \<linux\/ioctl.h\>
    \#include \<linux\/types.h\>
    \#include \<linux\/v4l2-common.h\>
    \#include \<linux\/v4l2-controls.h\>

    \/\*
     \* Common stuff for both V4L1 and V4L2
     \* Moved from videodev.h
     \*\/
    \#define VIDEO\_MAX\_FRAME               32
    \#define VIDEO\_MAX\_PLANES               8

    \/\*
     \*      M I S C E L L A N E O U S
     \*\/

    \/\*  Four-character-code (FOURCC) \*\/
    \#define v4l2\_fourcc(a, b, c, d)\\
            ((\_\_u32)(a) \| ((\_\_u32)(b) \<\< 8) \| ((\_\_u32)(c) \<\< 16) \| ((\_\_u32)(d) \<\< 24))
    \#define v4l2\_fourcc\_be(a, b, c, d)      (v4l2\_fourcc(a, b, c, d) \| (1U \<\< 31))

    \/\*
     \*      E N U M S
     \*\/
    enum :c:type:`v4l2_field` \{
            :c:type:`V4L2_FIELD_ANY <v4l2_field>`           = 0, \/\* driver can choose from none,
                                             top, bottom, interlaced
                                             depending on whatever it thinks
                                             is approximate ... \*\/
            :c:type:`V4L2_FIELD_NONE <v4l2_field>`          = 1, \/\* this device has no fields ... \*\/
            :c:type:`V4L2_FIELD_TOP <v4l2_field>`           = 2, \/\* top field only \*\/
            :c:type:`V4L2_FIELD_BOTTOM <v4l2_field>`        = 3, \/\* bottom field only \*\/
            :c:type:`V4L2_FIELD_INTERLACED <v4l2_field>`    = 4, \/\* both fields interlaced \*\/
            :c:type:`V4L2_FIELD_SEQ_TB <v4l2_field>`        = 5, \/\* both fields sequential into one
                                             buffer, top-bottom order \*\/
            :c:type:`V4L2_FIELD_SEQ_BT <v4l2_field>`        = 6, \/\* same as above + bottom-top order \*\/
            :c:type:`V4L2_FIELD_ALTERNATE <v4l2_field>`     = 7, \/\* both fields alternating into
                                             separate buffers \*\/
            :c:type:`V4L2_FIELD_INTERLACED_TB <v4l2_field>` = 8, \/\* both fields interlaced, top field
                                             first and the top field is
                                             transmitted first \*\/
            :c:type:`V4L2_FIELD_INTERLACED_BT <v4l2_field>` = 9, \/\* both fields interlaced, top field
                                             first and the bottom field is
                                             transmitted first \*\/
    \};
    \#define V4L2\_FIELD\_HAS\_TOP(field)       \\
            ((field) == :c:type:`V4L2_FIELD_TOP <v4l2_field>`      \|\|\\
             (field) == :c:type:`V4L2_FIELD_INTERLACED <v4l2_field>` \|\|\\
             (field) == :c:type:`V4L2_FIELD_INTERLACED_TB <v4l2_field>` \|\|\\
             (field) == :c:type:`V4L2_FIELD_INTERLACED_BT <v4l2_field>` \|\|\\
             (field) == :c:type:`V4L2_FIELD_SEQ_TB <v4l2_field>`   \|\|\\
             (field) == :c:type:`V4L2_FIELD_SEQ_BT <v4l2_field>`)
    \#define V4L2\_FIELD\_HAS\_BOTTOM(field)    \\
            ((field) == :c:type:`V4L2_FIELD_BOTTOM <v4l2_field>`   \|\|\\
             (field) == :c:type:`V4L2_FIELD_INTERLACED <v4l2_field>` \|\|\\
             (field) == :c:type:`V4L2_FIELD_INTERLACED_TB <v4l2_field>` \|\|\\
             (field) == :c:type:`V4L2_FIELD_INTERLACED_BT <v4l2_field>` \|\|\\
             (field) == :c:type:`V4L2_FIELD_SEQ_TB <v4l2_field>`   \|\|\\
             (field) == :c:type:`V4L2_FIELD_SEQ_BT <v4l2_field>`)
    \#define V4L2\_FIELD\_HAS\_BOTH(field)      \\
            ((field) == :c:type:`V4L2_FIELD_INTERLACED <v4l2_field>` \|\|\\
             (field) == :c:type:`V4L2_FIELD_INTERLACED_TB <v4l2_field>` \|\|\\
             (field) == :c:type:`V4L2_FIELD_INTERLACED_BT <v4l2_field>` \|\|\\
             (field) == :c:type:`V4L2_FIELD_SEQ_TB <v4l2_field>` \|\|\\
             (field) == :c:type:`V4L2_FIELD_SEQ_BT <v4l2_field>`)
    \#define V4L2\_FIELD\_HAS\_T\_OR\_B(field)    \\
            ((field) == :c:type:`V4L2_FIELD_BOTTOM <v4l2_field>` \|\|\\
             (field) == :c:type:`V4L2_FIELD_TOP <v4l2_field>` \|\|\\
             (field) == :c:type:`V4L2_FIELD_ALTERNATE <v4l2_field>`)
    \#define V4L2\_FIELD\_IS\_INTERLACED(field) \\
            ((field) == :c:type:`V4L2_FIELD_INTERLACED <v4l2_field>` \|\|\\
             (field) == :c:type:`V4L2_FIELD_INTERLACED_TB <v4l2_field>` \|\|\\
             (field) == :c:type:`V4L2_FIELD_INTERLACED_BT <v4l2_field>`)
    \#define V4L2\_FIELD\_IS\_SEQUENTIAL(field) \\
            ((field) == :c:type:`V4L2_FIELD_SEQ_TB <v4l2_field>` \|\|\\
             (field) == :c:type:`V4L2_FIELD_SEQ_BT <v4l2_field>`)

    enum :c:type:`v4l2_buf_type` \{
            :c:type:`V4L2_BUF_TYPE_VIDEO_CAPTURE <v4l2_buf_type>`        = 1,
            :c:type:`V4L2_BUF_TYPE_VIDEO_OUTPUT <v4l2_buf_type>`         = 2,
            :c:type:`V4L2_BUF_TYPE_VIDEO_OVERLAY <v4l2_buf_type>`        = 3,
            :c:type:`V4L2_BUF_TYPE_VBI_CAPTURE <v4l2_buf_type>`          = 4,
            :c:type:`V4L2_BUF_TYPE_VBI_OUTPUT <v4l2_buf_type>`           = 5,
            :c:type:`V4L2_BUF_TYPE_SLICED_VBI_CAPTURE <v4l2_buf_type>`   = 6,
            :c:type:`V4L2_BUF_TYPE_SLICED_VBI_OUTPUT <v4l2_buf_type>`    = 7,
            :c:type:`V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY <v4l2_buf_type>` = 8,
            :c:type:`V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE <v4l2_buf_type>` = 9,
            :c:type:`V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE <v4l2_buf_type>`  = 10,
            :c:type:`V4L2_BUF_TYPE_SDR_CAPTURE <v4l2_buf_type>`          = 11,
            :c:type:`V4L2_BUF_TYPE_SDR_OUTPUT <v4l2_buf_type>`           = 12,
            :c:type:`V4L2_BUF_TYPE_META_CAPTURE <v4l2_buf_type>`         = 13,
            :c:type:`V4L2_BUF_TYPE_META_OUTPUT <v4l2_buf_type>`          = 14,
            \/\* Deprecated, do not use \*\/
            V4L2\_BUF\_TYPE\_PRIVATE              = 0x80,
    \};

    \#define V4L2\_TYPE\_IS\_MULTIPLANAR(type)                  \\
            ((type) == :c:type:`V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE <v4l2_buf_type>`   \\
             \|\| (type) == :c:type:`V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE <v4l2_buf_type>`)

    \#define V4L2\_TYPE\_IS\_OUTPUT(type)                               \\
            ((type) == :c:type:`V4L2_BUF_TYPE_VIDEO_OUTPUT <v4l2_buf_type>`                   \\
             \|\| (type) == :c:type:`V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE <v4l2_buf_type>`         \\
             \|\| (type) == :c:type:`V4L2_BUF_TYPE_VIDEO_OVERLAY <v4l2_buf_type>`               \\
             \|\| (type) == :c:type:`V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY <v4l2_buf_type>`        \\
             \|\| (type) == :c:type:`V4L2_BUF_TYPE_VBI_OUTPUT <v4l2_buf_type>`                  \\
             \|\| (type) == :c:type:`V4L2_BUF_TYPE_SLICED_VBI_OUTPUT <v4l2_buf_type>`           \\
             \|\| (type) == :c:type:`V4L2_BUF_TYPE_SDR_OUTPUT <v4l2_buf_type>`                  \\
             \|\| (type) == :c:type:`V4L2_BUF_TYPE_META_OUTPUT <v4l2_buf_type>`)

    \#define V4L2\_TYPE\_IS\_CAPTURE(type) (!V4L2\_TYPE\_IS\_OUTPUT(type))

    enum :c:type:`v4l2_tuner_type` \{
            :c:type:`V4L2_TUNER_RADIO <v4l2_tuner_type>`             = 1,
            :c:type:`V4L2_TUNER_ANALOG_TV <v4l2_tuner_type>`         = 2,
            V4L2\_TUNER\_DIGITAL\_TV        = 3,
            :c:type:`V4L2_TUNER_SDR <v4l2_tuner_type>`               = 4,
            :c:type:`V4L2_TUNER_RF <v4l2_tuner_type>`                = 5,
    \};

    \/\* Deprecated, do not use \*\/
    \#define V4L2\_TUNER\_ADC  :c:type:`V4L2_TUNER_SDR <v4l2_tuner_type>`

    enum :c:type:`v4l2_memory` \{
            :c:type:`V4L2_MEMORY_MMAP <v4l2_memory>`             = 1,
            :c:type:`V4L2_MEMORY_USERPTR <v4l2_memory>`          = 2,
            :c:type:`V4L2_MEMORY_OVERLAY <v4l2_memory>`          = 3,
            :c:type:`V4L2_MEMORY_DMABUF <v4l2_memory>`           = 4,
    \};

    \/\* see also http\:\/\/vektor.theorem.ca\/graphics\/ycbcr\/ \*\/
    enum :c:type:`v4l2_colorspace` \{
            \/\*
             \* Default colorspace, i.e. let the driver figure it out.
             \* Can only be used with video capture.
             \*\/
            :c:type:`V4L2_COLORSPACE_DEFAULT <v4l2_colorspace>`       = 0,

            \/\* SMPTE 170M\: used for broadcast NTSC\/PAL SDTV \*\/
            :c:type:`V4L2_COLORSPACE_SMPTE170M <v4l2_colorspace>`     = 1,

            \/\* Obsolete pre-1998 SMPTE 240M HDTV standard, superseded by Rec 709 \*\/
            :c:type:`V4L2_COLORSPACE_SMPTE240M <v4l2_colorspace>`     = 2,

            \/\* Rec.709\: used for HDTV \*\/
            :c:type:`V4L2_COLORSPACE_REC709 <v4l2_colorspace>`        = 3,

            \/\*
             \* Deprecated, do not use. No driver will ever return this. This was
             \* based on a misunderstanding of the bt878 datasheet.
             \*\/
            V4L2\_COLORSPACE\_BT878         = 4,

            \/\*
             \* NTSC 1953 colorspace. This only makes sense when dealing with
             \* really, really old NTSC recordings. Superseded by SMPTE 170M.
             \*\/
            :c:type:`V4L2_COLORSPACE_470_SYSTEM_M <v4l2_colorspace>`  = 5,

            \/\*
             \* EBU Tech 3213 PAL\/SECAM colorspace. This only makes sense when
             \* dealing with really old PAL\/SECAM recordings. Superseded by
             \* SMPTE 170M.
             \*\/
            :c:type:`V4L2_COLORSPACE_470_SYSTEM_BG <v4l2_colorspace>` = 6,

            \/\*
             \* Effectively shorthand for :c:type:`V4L2_COLORSPACE_SRGB <v4l2_colorspace>`, :c:type:`V4L2_YCBCR_ENC_601 <v4l2_ycbcr_encoding>`
             \* and V4L2\_QUANTIZATION\_FULL\_RANGE. To be used for (Motion-)JPEG.
             \*\/
            :c:type:`V4L2_COLORSPACE_JPEG <v4l2_colorspace>`          = 7,

            \/\* For RGB colorspaces such as produces by most webcams. \*\/
            :c:type:`V4L2_COLORSPACE_SRGB <v4l2_colorspace>`          = 8,

            \/\* opRGB colorspace \*\/
            :c:type:`V4L2_COLORSPACE_OPRGB <v4l2_colorspace>`         = 9,

            \/\* BT.2020 colorspace, used for UHDTV. \*\/
            :c:type:`V4L2_COLORSPACE_BT2020 <v4l2_colorspace>`        = 10,

            \/\* Raw colorspace\: for RAW unprocessed images \*\/
            :c:type:`V4L2_COLORSPACE_RAW <v4l2_colorspace>`           = 11,

            \/\* DCI-P3 colorspace, used by cinema projectors \*\/
            :c:type:`V4L2_COLORSPACE_DCI_P3 <v4l2_colorspace>`        = 12,
    \};

    \/\*
     \* Determine how COLORSPACE\_DEFAULT should map to a proper colorspace.
     \* This depends on whether this is a SDTV image (use SMPTE 170M), an
     \* HDTV image (use Rec. 709), or something else (use sRGB).
     \*\/
    \#define V4L2\_MAP\_COLORSPACE\_DEFAULT(is\_sdtv, is\_hdtv) \\
            ((is\_sdtv) ? :c:type:`V4L2_COLORSPACE_SMPTE170M <v4l2_colorspace>` \: \\
             ((is\_hdtv) ? :c:type:`V4L2_COLORSPACE_REC709 <v4l2_colorspace>` \: :c:type:`V4L2_COLORSPACE_SRGB <v4l2_colorspace>`))

    enum :c:type:`v4l2_xfer_func` \{
            \/\*
             \* Mapping of :c:type:`V4L2_XFER_FUNC_DEFAULT <v4l2_xfer_func>` to actual transfer functions
             \* for the various colorspaces\:
             \*
             \* :c:type:`V4L2_COLORSPACE_SMPTE170M <v4l2_colorspace>`, :c:type:`V4L2_COLORSPACE_470_SYSTEM_M <v4l2_colorspace>`,
             \* :c:type:`V4L2_COLORSPACE_470_SYSTEM_BG <v4l2_colorspace>`, :c:type:`V4L2_COLORSPACE_REC709 <v4l2_colorspace>` and
             \* :c:type:`V4L2_COLORSPACE_BT2020 <v4l2_colorspace>`\: :c:type:`V4L2_XFER_FUNC_709 <v4l2_xfer_func>`
             \*
             \* :c:type:`V4L2_COLORSPACE_SRGB <v4l2_colorspace>`, :c:type:`V4L2_COLORSPACE_JPEG <v4l2_colorspace>`\: :c:type:`V4L2_XFER_FUNC_SRGB <v4l2_xfer_func>`
             \*
             \* :c:type:`V4L2_COLORSPACE_OPRGB <v4l2_colorspace>`\: :c:type:`V4L2_XFER_FUNC_OPRGB <v4l2_xfer_func>`
             \*
             \* :c:type:`V4L2_COLORSPACE_SMPTE240M <v4l2_colorspace>`\: :c:type:`V4L2_XFER_FUNC_SMPTE240M <v4l2_xfer_func>`
             \*
             \* :c:type:`V4L2_COLORSPACE_RAW <v4l2_colorspace>`\: :c:type:`V4L2_XFER_FUNC_NONE <v4l2_xfer_func>`
             \*
             \* :c:type:`V4L2_COLORSPACE_DCI_P3 <v4l2_colorspace>`\: :c:type:`V4L2_XFER_FUNC_DCI_P3 <v4l2_xfer_func>`
             \*\/
            :c:type:`V4L2_XFER_FUNC_DEFAULT <v4l2_xfer_func>`     = 0,
            :c:type:`V4L2_XFER_FUNC_709 <v4l2_xfer_func>`         = 1,
            :c:type:`V4L2_XFER_FUNC_SRGB <v4l2_xfer_func>`        = 2,
            :c:type:`V4L2_XFER_FUNC_OPRGB <v4l2_xfer_func>`       = 3,
            :c:type:`V4L2_XFER_FUNC_SMPTE240M <v4l2_xfer_func>`   = 4,
            :c:type:`V4L2_XFER_FUNC_NONE <v4l2_xfer_func>`        = 5,
            :c:type:`V4L2_XFER_FUNC_DCI_P3 <v4l2_xfer_func>`      = 6,
            :c:type:`V4L2_XFER_FUNC_SMPTE2084 <v4l2_xfer_func>`   = 7,
    \};

    \/\*
     \* Determine how XFER\_FUNC\_DEFAULT should map to a proper transfer function.
     \* This depends on the colorspace.
     \*\/
    \#define V4L2\_MAP\_XFER\_FUNC\_DEFAULT(colsp) \\
            ((colsp) == :c:type:`V4L2_COLORSPACE_OPRGB <v4l2_colorspace>` ? :c:type:`V4L2_XFER_FUNC_OPRGB <v4l2_xfer_func>` \: \\
             ((colsp) == :c:type:`V4L2_COLORSPACE_SMPTE240M <v4l2_colorspace>` ? :c:type:`V4L2_XFER_FUNC_SMPTE240M <v4l2_xfer_func>` \: \\
              ((colsp) == :c:type:`V4L2_COLORSPACE_DCI_P3 <v4l2_colorspace>` ? :c:type:`V4L2_XFER_FUNC_DCI_P3 <v4l2_xfer_func>` \: \\
               ((colsp) == :c:type:`V4L2_COLORSPACE_RAW <v4l2_colorspace>` ? :c:type:`V4L2_XFER_FUNC_NONE <v4l2_xfer_func>` \: \\
                ((colsp) == :c:type:`V4L2_COLORSPACE_SRGB <v4l2_colorspace>` \|\| (colsp) == :c:type:`V4L2_COLORSPACE_JPEG <v4l2_colorspace>` ? \\
                 :c:type:`V4L2_XFER_FUNC_SRGB <v4l2_xfer_func>` \: :c:type:`V4L2_XFER_FUNC_709 <v4l2_xfer_func>`)))))

    enum :c:type:`v4l2_ycbcr_encoding` \{
            \/\*
             \* Mapping of :c:type:`V4L2_YCBCR_ENC_DEFAULT <v4l2_ycbcr_encoding>` to actual encodings for the
             \* various colorspaces\:
             \*
             \* :c:type:`V4L2_COLORSPACE_SMPTE170M <v4l2_colorspace>`, :c:type:`V4L2_COLORSPACE_470_SYSTEM_M <v4l2_colorspace>`,
             \* :c:type:`V4L2_COLORSPACE_470_SYSTEM_BG <v4l2_colorspace>`, :c:type:`V4L2_COLORSPACE_SRGB <v4l2_colorspace>`,
             \* :c:type:`V4L2_COLORSPACE_OPRGB <v4l2_colorspace>` and :c:type:`V4L2_COLORSPACE_JPEG <v4l2_colorspace>`\: :c:type:`V4L2_YCBCR_ENC_601 <v4l2_ycbcr_encoding>`
             \*
             \* :c:type:`V4L2_COLORSPACE_REC709 <v4l2_colorspace>` and :c:type:`V4L2_COLORSPACE_DCI_P3 <v4l2_colorspace>`\: :c:type:`V4L2_YCBCR_ENC_709 <v4l2_ycbcr_encoding>`
             \*
             \* :c:type:`V4L2_COLORSPACE_BT2020 <v4l2_colorspace>`\: :c:type:`V4L2_YCBCR_ENC_BT2020 <v4l2_ycbcr_encoding>`
             \*
             \* :c:type:`V4L2_COLORSPACE_SMPTE240M <v4l2_colorspace>`\: :c:type:`V4L2_YCBCR_ENC_SMPTE240M <v4l2_ycbcr_encoding>`
             \*\/
            :c:type:`V4L2_YCBCR_ENC_DEFAULT <v4l2_ycbcr_encoding>`        = 0,

            \/\* ITU-R 601 -- SDTV \*\/
            :c:type:`V4L2_YCBCR_ENC_601 <v4l2_ycbcr_encoding>`            = 1,

            \/\* Rec. 709 -- HDTV \*\/
            :c:type:`V4L2_YCBCR_ENC_709 <v4l2_ycbcr_encoding>`            = 2,

            \/\* ITU-R 601\/EN 61966-2-4 Extended Gamut -- SDTV \*\/
            :c:type:`V4L2_YCBCR_ENC_XV601 <v4l2_ycbcr_encoding>`          = 3,

            \/\* Rec. 709\/EN 61966-2-4 Extended Gamut -- HDTV \*\/
            :c:type:`V4L2_YCBCR_ENC_XV709 <v4l2_ycbcr_encoding>`          = 4,

    \#ifndef \_\_KERNEL\_\_
            \/\*
             \* sYCC (Y'CbCr encoding of sRGB), identical to ENC\_601. It was added
             \* originally due to a misunderstanding of the sYCC standard. It should
             \* not be used, instead use V4L2\_YCBCR\_ENC\_601.
             \*\/
            :c:type:`V4L2_YCBCR_ENC_SYCC <v4l2_ycbcr_encoding>`           = 5,
    \#endif

            \/\* BT.2020 Non-constant Luminance Y'CbCr \*\/
            :c:type:`V4L2_YCBCR_ENC_BT2020 <v4l2_ycbcr_encoding>`         = 6,

            \/\* BT.2020 Constant Luminance Y'CbcCrc \*\/
            :c:type:`V4L2_YCBCR_ENC_BT2020_CONST_LUM <v4l2_ycbcr_encoding>` = 7,

            \/\* SMPTE 240M -- Obsolete HDTV \*\/
            :c:type:`V4L2_YCBCR_ENC_SMPTE240M <v4l2_ycbcr_encoding>`      = 8,
    \};

    \/\*
     \* enum :c:type:`v4l2_hsv_encoding` values should not collide with the ones from
     \* enum v4l2\_ycbcr\_encoding.
     \*\/
    enum :c:type:`v4l2_hsv_encoding` \{

            \/\* Hue mapped to 0 - 179 \*\/
            :c:type:`V4L2_HSV_ENC_180 <v4l2_hsv_encoding>`                = 128,

            \/\* Hue mapped to 0-255 \*\/
            :c:type:`V4L2_HSV_ENC_256 <v4l2_hsv_encoding>`                = 129,
    \};

    \/\*
     \* Determine how YCBCR\_ENC\_DEFAULT should map to a proper Y'CbCr encoding.
     \* This depends on the colorspace.
     \*\/
    \#define V4L2\_MAP\_YCBCR\_ENC\_DEFAULT(colsp) \\
            (((colsp) == :c:type:`V4L2_COLORSPACE_REC709 <v4l2_colorspace>` \|\| \\
              (colsp) == :c:type:`V4L2_COLORSPACE_DCI_P3 <v4l2_colorspace>`) ? :c:type:`V4L2_YCBCR_ENC_709 <v4l2_ycbcr_encoding>` \: \\
             ((colsp) == :c:type:`V4L2_COLORSPACE_BT2020 <v4l2_colorspace>` ? :c:type:`V4L2_YCBCR_ENC_BT2020 <v4l2_ycbcr_encoding>` \: \\
              ((colsp) == :c:type:`V4L2_COLORSPACE_SMPTE240M <v4l2_colorspace>` ? :c:type:`V4L2_YCBCR_ENC_SMPTE240M <v4l2_ycbcr_encoding>` \: \\
               :c:type:`V4L2_YCBCR_ENC_601 <v4l2_ycbcr_encoding>`)))

    enum :c:type:`v4l2_quantization` \{
            \/\*
             \* The default for R'G'B' quantization is always full range.
             \* For Y'CbCr the quantization is always limited range, except
             \* for COLORSPACE\_JPEG\: this is full range.
             \*\/
            :c:type:`V4L2_QUANTIZATION_DEFAULT <v4l2_quantization>`     = 0,
            :c:type:`V4L2_QUANTIZATION_FULL_RANGE <v4l2_quantization>`  = 1,
            :c:type:`V4L2_QUANTIZATION_LIM_RANGE <v4l2_quantization>`   = 2,
    \};

    \/\*
     \* Determine how QUANTIZATION\_DEFAULT should map to a proper quantization.
     \* This depends on whether the image is RGB or not, the colorspace.
     \* The Y'CbCr encoding is not used anymore, but is still there for backwards
     \* compatibility.
     \*\/
    \#define V4L2\_MAP\_QUANTIZATION\_DEFAULT(is\_rgb\_or\_hsv, colsp, ycbcr\_enc) \\
            (((is\_rgb\_or\_hsv) \|\| (colsp) == :c:type:`V4L2_COLORSPACE_JPEG <v4l2_colorspace>`) ? \\
             :c:type:`V4L2_QUANTIZATION_FULL_RANGE <v4l2_quantization>` \: :c:type:`V4L2_QUANTIZATION_LIM_RANGE <v4l2_quantization>`)

    \/\*
     \* Deprecated names for opRGB colorspace (IEC 61966-2-5)
     \*
     \* WARNING\: Please don't use these deprecated defines in your code, as
     \* there is a chance we have to remove them in the future.
     \*\/
    \#ifndef \_\_KERNEL\_\_
    \#define :c:type:`V4L2_COLORSPACE_ADOBERGB <v4l2_colorspace>` :c:type:`V4L2_COLORSPACE_OPRGB <v4l2_colorspace>`
    \#define :c:type:`V4L2_XFER_FUNC_ADOBERGB <v4l2_xfer_func>`  :c:type:`V4L2_XFER_FUNC_OPRGB <v4l2_xfer_func>`
    \#endif

    enum :c:type:`v4l2_priority` \{
            :c:type:`V4L2_PRIORITY_UNSET <v4l2_priority>`       = 0,  \/\* not initialized \*\/
            :c:type:`V4L2_PRIORITY_BACKGROUND <v4l2_priority>`  = 1,
            :c:type:`V4L2_PRIORITY_INTERACTIVE <v4l2_priority>` = 2,
            :c:type:`V4L2_PRIORITY_RECORD <v4l2_priority>`      = 3,
            :c:type:`V4L2_PRIORITY_DEFAULT <v4l2_priority>`     = :c:type:`V4L2_PRIORITY_INTERACTIVE <v4l2_priority>`,
    \};

    struct v4l2_rect \{
            \_\_s32   left;
            \_\_s32   top;
            \_\_u32   width;
            \_\_u32   height;
    \};

    struct v4l2_fract \{
            \_\_u32   numerator;
            \_\_u32   denominator;
    \};

    struct v4l2_area \{
            \_\_u32   width;
            \_\_u32   height;
    \};

    \/\*\*
      \* struct v4l2_capability - Describes V4L2 device caps returned by \ :ref:`VIDIOC_QUERYCAP <vidioc_querycap>`
      \*
      \* @driver\:       name of the driver module (e.g. "bttv")
      \* @card\:         name of the card (e.g. "Hauppauge WinTV")
      \* @bus\_info\:     name of the bus (e.g. "PCI\:" + pci\_name(pci\_dev) )
      \* @version\:      KERNEL\_VERSION
      \* @capabilities\: capabilities of the physical device as a whole
      \* @device\_caps\:  capabilities accessed via this particular device (node)
      \* @reserved\:     reserved fields for future extensions
      \*\/
    struct v4l2_capability \{
            \_\_u8    driver[16];
            \_\_u8    card[32];
            \_\_u8    bus\_info[32];
            \_\_u32   version;
            \_\_u32   capabilities;
            \_\_u32   device\_caps;
            \_\_u32   reserved[3];
    \};

    \/\* Values for 'capabilities' field \*\/
    \#define :ref:`V4L2_CAP_VIDEO_CAPTURE <device-capabilities>`          0x00000001  \/\* Is a video capture device \*\/
    \#define :ref:`V4L2_CAP_VIDEO_OUTPUT <device-capabilities>`           0x00000002  \/\* Is a video output device \*\/
    \#define :ref:`V4L2_CAP_VIDEO_OVERLAY <device-capabilities>`          0x00000004  \/\* Can do video overlay \*\/
    \#define :ref:`V4L2_CAP_VBI_CAPTURE <device-capabilities>`            0x00000010  \/\* Is a raw VBI capture device \*\/
    \#define :ref:`V4L2_CAP_VBI_OUTPUT <device-capabilities>`             0x00000020  \/\* Is a raw VBI output device \*\/
    \#define :ref:`V4L2_CAP_SLICED_VBI_CAPTURE <device-capabilities>`     0x00000040  \/\* Is a sliced VBI capture device \*\/
    \#define :ref:`V4L2_CAP_SLICED_VBI_OUTPUT <device-capabilities>`      0x00000080  \/\* Is a sliced VBI output device \*\/
    \#define :ref:`V4L2_CAP_RDS_CAPTURE <device-capabilities>`            0x00000100  \/\* RDS data capture \*\/
    \#define :ref:`V4L2_CAP_VIDEO_OUTPUT_OVERLAY <device-capabilities>`   0x00000200  \/\* Can do video output overlay \*\/
    \#define :ref:`V4L2_CAP_HW_FREQ_SEEK <device-capabilities>`           0x00000400  \/\* Can do hardware frequency seek  \*\/
    \#define :ref:`V4L2_CAP_RDS_OUTPUT <device-capabilities>`             0x00000800  \/\* Is an RDS encoder \*\/

    \/\* Is a video capture device that supports multiplanar formats \*\/
    \#define :ref:`V4L2_CAP_VIDEO_CAPTURE_MPLANE <device-capabilities>`   0x00001000
    \/\* Is a video output device that supports multiplanar formats \*\/
    \#define :ref:`V4L2_CAP_VIDEO_OUTPUT_MPLANE <device-capabilities>`    0x00002000
    \/\* Is a video mem-to-mem device that supports multiplanar formats \*\/
    \#define :ref:`V4L2_CAP_VIDEO_M2M_MPLANE <device-capabilities>`       0x00004000
    \/\* Is a video mem-to-mem device \*\/
    \#define :ref:`V4L2_CAP_VIDEO_M2M <device-capabilities>`              0x00008000

    \#define :ref:`V4L2_CAP_TUNER <device-capabilities>`                  0x00010000  \/\* has a tuner \*\/
    \#define :ref:`V4L2_CAP_AUDIO <device-capabilities>`                  0x00020000  \/\* has audio support \*\/
    \#define :ref:`V4L2_CAP_RADIO <device-capabilities>`                  0x00040000  \/\* is a radio device \*\/
    \#define :ref:`V4L2_CAP_MODULATOR <device-capabilities>`              0x00080000  \/\* has a modulator \*\/

    \#define :ref:`V4L2_CAP_SDR_CAPTURE <device-capabilities>`            0x00100000  \/\* Is a SDR capture device \*\/
    \#define :ref:`V4L2_CAP_EXT_PIX_FORMAT <device-capabilities>`         0x00200000  \/\* Supports the extended pixel format \*\/
    \#define :ref:`V4L2_CAP_SDR_OUTPUT <device-capabilities>`             0x00400000  \/\* Is a SDR output device \*\/
    \#define :ref:`V4L2_CAP_META_CAPTURE <device-capabilities>`           0x00800000  \/\* Is a metadata capture device \*\/

    \#define :ref:`V4L2_CAP_READWRITE <device-capabilities>`              0x01000000  \/\* read\/write systemcalls \*\/
    \#define :ref:`V4L2_CAP_ASYNCIO <device-capabilities>`                0x02000000  \/\* async I\/O \*\/
    \#define :ref:`V4L2_CAP_STREAMING <device-capabilities>`              0x04000000  \/\* streaming I\/O ioctls \*\/
    \#define :ref:`V4L2_CAP_META_OUTPUT <device-capabilities>`            0x08000000  \/\* Is a metadata output device \*\/

    \#define :ref:`V4L2_CAP_TOUCH <device-capabilities>`                  0x10000000  \/\* Is a touch device \*\/

    \#define :ref:`V4L2_CAP_IO_MC <device-capabilities>`                  0x20000000  \/\* Is input\/output controlled by the media controller \*\/

    \#define :ref:`V4L2_CAP_DEVICE_CAPS <device-capabilities>`            0x80000000  \/\* sets device capabilities field \*\/

    \/\*
     \*      V I D E O   I M A G E   F O R M A T
     \*\/
    struct v4l2_pix_format \{
            \_\_u32                   width;
            \_\_u32                   height;
            \_\_u32                   pixelformat;
            \_\_u32                   field;          \/\* enum :c:type:`v4l2_field` \*\/
            \_\_u32                   bytesperline;   \/\* for padding, zero if unused \*\/
            \_\_u32                   sizeimage;
            \_\_u32                   colorspace;     \/\* enum :c:type:`v4l2_colorspace` \*\/
            \_\_u32                   priv;           \/\* private data, depends on pixelformat \*\/
            \_\_u32                   flags;          \/\* format flags (V4L2\_PIX\_FMT\_FLAG\_\*) \*\/
            union \{
                    \/\* enum :c:type:`v4l2_ycbcr_encoding` \*\/
                    \_\_u32                   ycbcr\_enc;
                    \/\* enum :c:type:`v4l2_hsv_encoding` \*\/
                    \_\_u32                   hsv\_enc;
            \};
            \_\_u32                   quantization;   \/\* enum :c:type:`v4l2_quantization` \*\/
            \_\_u32                   xfer\_func;      \/\* enum :c:type:`v4l2_xfer_func` \*\/
    \};

    \/\*      Pixel format         FOURCC                          depth  Description  \*\/

    \/\* RGB formats \*\/
    \#define \ :ref:`V4L2_PIX_FMT_RGB332 <v4l2-pix-fmt-rgb332>`  v4l2\_fourcc('R', 'G', 'B', '1') \/\*  8  RGB-3-3-2     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_RGB444 <v4l2-pix-fmt-rgb444>`  v4l2\_fourcc('R', '4', '4', '4') \/\* 16  xxxxrrrr ggggbbbb \*\/
    \#define \ :ref:`V4L2_PIX_FMT_ARGB444 <v4l2-pix-fmt-argb444>` v4l2\_fourcc('A', 'R', '1', '2') \/\* 16  aaaarrrr ggggbbbb \*\/
    \#define \ :ref:`V4L2_PIX_FMT_XRGB444 <v4l2-pix-fmt-xrgb444>` v4l2\_fourcc('X', 'R', '1', '2') \/\* 16  xxxxrrrr ggggbbbb \*\/
    \#define \ :ref:`V4L2_PIX_FMT_RGBA444 <v4l2-pix-fmt-rgba444>` v4l2\_fourcc('R', 'A', '1', '2') \/\* 16  rrrrgggg bbbbaaaa \*\/
    \#define \ :ref:`V4L2_PIX_FMT_RGBX444 <v4l2-pix-fmt-rgbx444>` v4l2\_fourcc('R', 'X', '1', '2') \/\* 16  rrrrgggg bbbbxxxx \*\/
    \#define \ :ref:`V4L2_PIX_FMT_ABGR444 <v4l2-pix-fmt-abgr444>` v4l2\_fourcc('A', 'B', '1', '2') \/\* 16  aaaabbbb ggggrrrr \*\/
    \#define \ :ref:`V4L2_PIX_FMT_XBGR444 <v4l2-pix-fmt-xbgr444>` v4l2\_fourcc('X', 'B', '1', '2') \/\* 16  xxxxbbbb ggggrrrr \*\/

    \/\*
     \* Originally this had 'BA12' as fourcc, but this clashed with the older
     \* \ :ref:`V4L2_PIX_FMT_SGRBG12 <v4l2-pix-fmt-sgrbg12>` which inexplicably used that same fourcc.
     \* So use 'GA12' instead for V4L2\_PIX\_FMT\_BGRA444.
     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_BGRA444 <v4l2-pix-fmt-bgra444>` v4l2\_fourcc('G', 'A', '1', '2') \/\* 16  bbbbgggg rrrraaaa \*\/
    \#define \ :ref:`V4L2_PIX_FMT_BGRX444 <v4l2-pix-fmt-bgrx444>` v4l2\_fourcc('B', 'X', '1', '2') \/\* 16  bbbbgggg rrrrxxxx \*\/
    \#define \ :ref:`V4L2_PIX_FMT_RGB555 <v4l2-pix-fmt-rgb555>`  v4l2\_fourcc('R', 'G', 'B', 'O') \/\* 16  RGB-5-5-5     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_ARGB555 <v4l2-pix-fmt-argb555>` v4l2\_fourcc('A', 'R', '1', '5') \/\* 16  ARGB-1-5-5-5  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_XRGB555 <v4l2-pix-fmt-xrgb555>` v4l2\_fourcc('X', 'R', '1', '5') \/\* 16  XRGB-1-5-5-5  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_RGBA555 <v4l2-pix-fmt-rgba555>` v4l2\_fourcc('R', 'A', '1', '5') \/\* 16  RGBA-5-5-5-1  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_RGBX555 <v4l2-pix-fmt-rgbx555>` v4l2\_fourcc('R', 'X', '1', '5') \/\* 16  RGBX-5-5-5-1  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_ABGR555 <v4l2-pix-fmt-abgr555>` v4l2\_fourcc('A', 'B', '1', '5') \/\* 16  ABGR-1-5-5-5  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_XBGR555 <v4l2-pix-fmt-xbgr555>` v4l2\_fourcc('X', 'B', '1', '5') \/\* 16  XBGR-1-5-5-5  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_BGRA555 <v4l2-pix-fmt-bgra555>` v4l2\_fourcc('B', 'A', '1', '5') \/\* 16  BGRA-5-5-5-1  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_BGRX555 <v4l2-pix-fmt-bgrx555>` v4l2\_fourcc('B', 'X', '1', '5') \/\* 16  BGRX-5-5-5-1  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_RGB565 <v4l2-pix-fmt-rgb565>`  v4l2\_fourcc('R', 'G', 'B', 'P') \/\* 16  RGB-5-6-5     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_RGB555X <v4l2-pix-fmt-rgb555x>` v4l2\_fourcc('R', 'G', 'B', 'Q') \/\* 16  RGB-5-5-5 BE  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_ARGB555X <v4l2-pix-fmt-argb555x>` v4l2\_fourcc\_be('A', 'R', '1', '5') \/\* 16  ARGB-5-5-5 BE \*\/
    \#define \ :ref:`V4L2_PIX_FMT_XRGB555X <v4l2-pix-fmt-xrgb555x>` v4l2\_fourcc\_be('X', 'R', '1', '5') \/\* 16  XRGB-5-5-5 BE \*\/
    \#define \ :ref:`V4L2_PIX_FMT_RGB565X <v4l2-pix-fmt-rgb565x>` v4l2\_fourcc('R', 'G', 'B', 'R') \/\* 16  RGB-5-6-5 BE  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_BGR666 <v4l2-pix-fmt-bgr666>`  v4l2\_fourcc('B', 'G', 'R', 'H') \/\* 18  BGR-6-6-6     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_BGR24 <v4l2-pix-fmt-bgr24>`   v4l2\_fourcc('B', 'G', 'R', '3') \/\* 24  BGR-8-8-8     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_RGB24 <v4l2-pix-fmt-rgb24>`   v4l2\_fourcc('R', 'G', 'B', '3') \/\* 24  RGB-8-8-8     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_BGR32 <v4l2-pix-fmt-bgr32>`   v4l2\_fourcc('B', 'G', 'R', '4') \/\* 32  BGR-8-8-8-8   \*\/
    \#define \ :ref:`V4L2_PIX_FMT_ABGR32 <v4l2-pix-fmt-abgr32>`  v4l2\_fourcc('A', 'R', '2', '4') \/\* 32  BGRA-8-8-8-8  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_XBGR32 <v4l2-pix-fmt-xbgr32>`  v4l2\_fourcc('X', 'R', '2', '4') \/\* 32  BGRX-8-8-8-8  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_BGRA32 <v4l2-pix-fmt-bgra32>`  v4l2\_fourcc('R', 'A', '2', '4') \/\* 32  ABGR-8-8-8-8  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_BGRX32 <v4l2-pix-fmt-bgrx32>`  v4l2\_fourcc('R', 'X', '2', '4') \/\* 32  XBGR-8-8-8-8  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_RGB32 <v4l2-pix-fmt-rgb32>`   v4l2\_fourcc('R', 'G', 'B', '4') \/\* 32  RGB-8-8-8-8   \*\/
    \#define \ :ref:`V4L2_PIX_FMT_RGBA32 <v4l2-pix-fmt-rgba32>`  v4l2\_fourcc('A', 'B', '2', '4') \/\* 32  RGBA-8-8-8-8  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_RGBX32 <v4l2-pix-fmt-rgbx32>`  v4l2\_fourcc('X', 'B', '2', '4') \/\* 32  RGBX-8-8-8-8  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_ARGB32 <v4l2-pix-fmt-argb32>`  v4l2\_fourcc('B', 'A', '2', '4') \/\* 32  ARGB-8-8-8-8  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_XRGB32 <v4l2-pix-fmt-xrgb32>`  v4l2\_fourcc('B', 'X', '2', '4') \/\* 32  XRGB-8-8-8-8  \*\/

    \/\* Grey formats \*\/
    \#define \ :ref:`V4L2_PIX_FMT_GREY <v4l2-pix-fmt-grey>`    v4l2\_fourcc('G', 'R', 'E', 'Y') \/\*  8  Greyscale     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_Y4 <v4l2-pix-fmt-y4>`      v4l2\_fourcc('Y', '0', '4', ' ') \/\*  4  Greyscale     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_Y6 <v4l2-pix-fmt-y6>`      v4l2\_fourcc('Y', '0', '6', ' ') \/\*  6  Greyscale     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_Y10 <v4l2-pix-fmt-y10>`     v4l2\_fourcc('Y', '1', '0', ' ') \/\* 10  Greyscale     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_Y12 <v4l2-pix-fmt-y12>`     v4l2\_fourcc('Y', '1', '2', ' ') \/\* 12  Greyscale     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_Y14 <v4l2-pix-fmt-y14>`     v4l2\_fourcc('Y', '1', '4', ' ') \/\* 14  Greyscale     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_Y16 <v4l2-pix-fmt-y16>`     v4l2\_fourcc('Y', '1', '6', ' ') \/\* 16  Greyscale     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_Y16_BE <v4l2-pix-fmt-y16-be>`  v4l2\_fourcc\_be('Y', '1', '6', ' ') \/\* 16  Greyscale BE  \*\/

    \/\* Grey bit-packed formats \*\/
    \#define \ :ref:`V4L2_PIX_FMT_Y10BPACK <v4l2-pix-fmt-y10bpack>`    v4l2\_fourcc('Y', '1', '0', 'B') \/\* 10  Greyscale bit-packed \*\/
    \#define \ :ref:`V4L2_PIX_FMT_Y10P <v4l2-pix-fmt-y10p>`    v4l2\_fourcc('Y', '1', '0', 'P') \/\* 10  Greyscale, MIPI RAW10 packed \*\/

    \/\* Palette formats \*\/
    \#define \ :ref:`V4L2_PIX_FMT_PAL8 <v4l2-pix-fmt-pal8>`    v4l2\_fourcc('P', 'A', 'L', '8') \/\*  8  8-bit palette \*\/

    \/\* Chrominance formats \*\/
    \#define \ :ref:`V4L2_PIX_FMT_UV8 <v4l2-pix-fmt-uv8>`     v4l2\_fourcc('U', 'V', '8', ' ') \/\*  8  UV 4\:4 \*\/

    \/\* Luminance+Chrominance formats \*\/
    \#define \ :ref:`V4L2_PIX_FMT_YUYV <v4l2-pix-fmt-yuyv>`    v4l2\_fourcc('Y', 'U', 'Y', 'V') \/\* 16  YUV 4\:2\:2     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_YYUV <v4l2-pix-fmt-yyuv>`    v4l2\_fourcc('Y', 'Y', 'U', 'V') \/\* 16  YUV 4\:2\:2     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_YVYU <v4l2-pix-fmt-yvyu>`    v4l2\_fourcc('Y', 'V', 'Y', 'U') \/\* 16 YVU 4\:2\:2 \*\/
    \#define \ :ref:`V4L2_PIX_FMT_UYVY <v4l2-pix-fmt-uyvy>`    v4l2\_fourcc('U', 'Y', 'V', 'Y') \/\* 16  YUV 4\:2\:2     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_VYUY <v4l2-pix-fmt-vyuy>`    v4l2\_fourcc('V', 'Y', 'U', 'Y') \/\* 16  YUV 4\:2\:2     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_Y41P <v4l2-pix-fmt-y41p>`    v4l2\_fourcc('Y', '4', '1', 'P') \/\* 12  YUV 4\:1\:1     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_YUV444 <v4l2-pix-fmt-yuv444>`  v4l2\_fourcc('Y', '4', '4', '4') \/\* 16  xxxxyyyy uuuuvvvv \*\/
    \#define \ :ref:`V4L2_PIX_FMT_YUV555 <v4l2-pix-fmt-yuv555>`  v4l2\_fourcc('Y', 'U', 'V', 'O') \/\* 16  YUV-5-5-5     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_YUV565 <v4l2-pix-fmt-yuv565>`  v4l2\_fourcc('Y', 'U', 'V', 'P') \/\* 16  YUV-5-6-5     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_YUV32 <v4l2-pix-fmt-yuv32>`   v4l2\_fourcc('Y', 'U', 'V', '4') \/\* 32  YUV-8-8-8-8   \*\/
    \#define \ :ref:`V4L2_PIX_FMT_AYUV32 <v4l2-pix-fmt-ayuv32>`  v4l2\_fourcc('A', 'Y', 'U', 'V') \/\* 32  AYUV-8-8-8-8  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_XYUV32 <v4l2-pix-fmt-xyuv32>`  v4l2\_fourcc('X', 'Y', 'U', 'V') \/\* 32  XYUV-8-8-8-8  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_VUYA32 <v4l2-pix-fmt-vuya32>`  v4l2\_fourcc('V', 'U', 'Y', 'A') \/\* 32  VUYA-8-8-8-8  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_VUYX32 <v4l2-pix-fmt-vuyx32>`  v4l2\_fourcc('V', 'U', 'Y', 'X') \/\* 32  VUYX-8-8-8-8  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_HI240 <v4l2-pix-fmt-hi240>`   v4l2\_fourcc('H', 'I', '2', '4') \/\*  8  8-bit color   \*\/
    \#define \ :ref:`V4L2_PIX_FMT_HM12 <v4l2-pix-fmt-hm12>`    v4l2\_fourcc('H', 'M', '1', '2') \/\*  8  YUV 4\:2\:0 16x16 macroblocks \*\/
    \#define \ :ref:`V4L2_PIX_FMT_M420 <v4l2-pix-fmt-m420>`    v4l2\_fourcc('M', '4', '2', '0') \/\* 12  YUV 4\:2\:0 2 lines y, 1 line uv interleaved \*\/

    \/\* two planes -- one Y, one Cr + Cb interleaved  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_NV12 <v4l2-pix-fmt-nv12>`    v4l2\_fourcc('N', 'V', '1', '2') \/\* 12  Y\/CbCr 4\:2\:0  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_NV21 <v4l2-pix-fmt-nv21>`    v4l2\_fourcc('N', 'V', '2', '1') \/\* 12  Y\/CrCb 4\:2\:0  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_NV16 <v4l2-pix-fmt-nv16>`    v4l2\_fourcc('N', 'V', '1', '6') \/\* 16  Y\/CbCr 4\:2\:2  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_NV61 <v4l2-pix-fmt-nv61>`    v4l2\_fourcc('N', 'V', '6', '1') \/\* 16  Y\/CrCb 4\:2\:2  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_NV24 <v4l2-pix-fmt-nv24>`    v4l2\_fourcc('N', 'V', '2', '4') \/\* 24  Y\/CbCr 4\:4\:4  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_NV42 <v4l2-pix-fmt-nv42>`    v4l2\_fourcc('N', 'V', '4', '2') \/\* 24  Y\/CrCb 4\:4\:4  \*\/

    \/\* two non contiguous planes - one Y, one Cr + Cb interleaved  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_NV12M <v4l2-pix-fmt-nv12m>`   v4l2\_fourcc('N', 'M', '1', '2') \/\* 12  Y\/CbCr 4\:2\:0  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_NV21M <v4l2-pix-fmt-nv21m>`   v4l2\_fourcc('N', 'M', '2', '1') \/\* 21  Y\/CrCb 4\:2\:0  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_NV16M <v4l2-pix-fmt-nv16m>`   v4l2\_fourcc('N', 'M', '1', '6') \/\* 16  Y\/CbCr 4\:2\:2  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_NV61M <v4l2-pix-fmt-nv61m>`   v4l2\_fourcc('N', 'M', '6', '1') \/\* 16  Y\/CrCb 4\:2\:2  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_NV12MT <v4l2-pix-fmt-nv12mt>`  v4l2\_fourcc('T', 'M', '1', '2') \/\* 12  Y\/CbCr 4\:2\:0 64x32 macroblocks \*\/
    \#define \ :ref:`V4L2_PIX_FMT_NV12MT_16X16 <v4l2-pix-fmt-nv12mt-16x16>` v4l2\_fourcc('V', 'M', '1', '2') \/\* 12  Y\/CbCr 4\:2\:0 16x16 macroblocks \*\/

    \/\* three planes - Y Cb, Cr \*\/
    \#define \ :ref:`V4L2_PIX_FMT_YUV410 <v4l2-pix-fmt-yuv410>`  v4l2\_fourcc('Y', 'U', 'V', '9') \/\*  9  YUV 4\:1\:0     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_YVU410 <v4l2-pix-fmt-yvu410>`  v4l2\_fourcc('Y', 'V', 'U', '9') \/\*  9  YVU 4\:1\:0     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_YUV411P <v4l2-pix-fmt-yuv411p>` v4l2\_fourcc('4', '1', '1', 'P') \/\* 12  YVU411 planar \*\/
    \#define \ :ref:`V4L2_PIX_FMT_YUV420 <v4l2-pix-fmt-yuv420>`  v4l2\_fourcc('Y', 'U', '1', '2') \/\* 12  YUV 4\:2\:0     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_YVU420 <v4l2-pix-fmt-yvu420>`  v4l2\_fourcc('Y', 'V', '1', '2') \/\* 12  YVU 4\:2\:0     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_YUV422P <v4l2-pix-fmt-yuv422p>` v4l2\_fourcc('4', '2', '2', 'P') \/\* 16  YVU422 planar \*\/

    \/\* three non contiguous planes - Y, Cb, Cr \*\/
    \#define \ :ref:`V4L2_PIX_FMT_YUV420M <v4l2-pix-fmt-yuv420m>` v4l2\_fourcc('Y', 'M', '1', '2') \/\* 12  YUV420 planar \*\/
    \#define \ :ref:`V4L2_PIX_FMT_YVU420M <v4l2-pix-fmt-yvu420m>` v4l2\_fourcc('Y', 'M', '2', '1') \/\* 12  YVU420 planar \*\/
    \#define \ :ref:`V4L2_PIX_FMT_YUV422M <v4l2-pix-fmt-yuv422m>` v4l2\_fourcc('Y', 'M', '1', '6') \/\* 16  YUV422 planar \*\/
    \#define \ :ref:`V4L2_PIX_FMT_YVU422M <v4l2-pix-fmt-yvu422m>` v4l2\_fourcc('Y', 'M', '6', '1') \/\* 16  YVU422 planar \*\/
    \#define \ :ref:`V4L2_PIX_FMT_YUV444M <v4l2-pix-fmt-yuv444m>` v4l2\_fourcc('Y', 'M', '2', '4') \/\* 24  YUV444 planar \*\/
    \#define \ :ref:`V4L2_PIX_FMT_YVU444M <v4l2-pix-fmt-yvu444m>` v4l2\_fourcc('Y', 'M', '4', '2') \/\* 24  YVU444 planar \*\/

    \/\* Bayer formats - see http\:\/\/www.siliconimaging.com\/RGB\%20Bayer.htm \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SBGGR8 <v4l2-pix-fmt-sbggr8>`  v4l2\_fourcc('B', 'A', '8', '1') \/\*  8  BGBG.. GRGR.. \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SGBRG8 <v4l2-pix-fmt-sgbrg8>`  v4l2\_fourcc('G', 'B', 'R', 'G') \/\*  8  GBGB.. RGRG.. \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SGRBG8 <v4l2-pix-fmt-sgrbg8>`  v4l2\_fourcc('G', 'R', 'B', 'G') \/\*  8  GRGR.. BGBG.. \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SRGGB8 <v4l2-pix-fmt-srggb8>`  v4l2\_fourcc('R', 'G', 'G', 'B') \/\*  8  RGRG.. GBGB.. \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SBGGR10 <v4l2-pix-fmt-sbggr10>` v4l2\_fourcc('B', 'G', '1', '0') \/\* 10  BGBG.. GRGR.. \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SGBRG10 <v4l2-pix-fmt-sgbrg10>` v4l2\_fourcc('G', 'B', '1', '0') \/\* 10  GBGB.. RGRG.. \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SGRBG10 <v4l2-pix-fmt-sgrbg10>` v4l2\_fourcc('B', 'A', '1', '0') \/\* 10  GRGR.. BGBG.. \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SRGGB10 <v4l2-pix-fmt-srggb10>` v4l2\_fourcc('R', 'G', '1', '0') \/\* 10  RGRG.. GBGB.. \*\/
            \/\* 10bit raw bayer packed, 5 bytes for every 4 pixels \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SBGGR10P <v4l2-pix-fmt-sbggr10p>` v4l2\_fourcc('p', 'B', 'A', 'A')
    \#define \ :ref:`V4L2_PIX_FMT_SGBRG10P <v4l2-pix-fmt-sgbrg10p>` v4l2\_fourcc('p', 'G', 'A', 'A')
    \#define \ :ref:`V4L2_PIX_FMT_SGRBG10P <v4l2-pix-fmt-sgrbg10p>` v4l2\_fourcc('p', 'g', 'A', 'A')
    \#define \ :ref:`V4L2_PIX_FMT_SRGGB10P <v4l2-pix-fmt-srggb10p>` v4l2\_fourcc('p', 'R', 'A', 'A')
            \/\* 10bit raw bayer a-law compressed to 8 bits \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SBGGR10ALAW8 <v4l2-pix-fmt-sbggr10alaw8>` v4l2\_fourcc('a', 'B', 'A', '8')
    \#define \ :ref:`V4L2_PIX_FMT_SGBRG10ALAW8 <v4l2-pix-fmt-sgbrg10alaw8>` v4l2\_fourcc('a', 'G', 'A', '8')
    \#define \ :ref:`V4L2_PIX_FMT_SGRBG10ALAW8 <v4l2-pix-fmt-sgrbg10alaw8>` v4l2\_fourcc('a', 'g', 'A', '8')
    \#define \ :ref:`V4L2_PIX_FMT_SRGGB10ALAW8 <v4l2-pix-fmt-srggb10alaw8>` v4l2\_fourcc('a', 'R', 'A', '8')
            \/\* 10bit raw bayer DPCM compressed to 8 bits \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SBGGR10DPCM8 <v4l2-pix-fmt-sbggr10dpcm8>` v4l2\_fourcc('b', 'B', 'A', '8')
    \#define \ :ref:`V4L2_PIX_FMT_SGBRG10DPCM8 <v4l2-pix-fmt-sgbrg10dpcm8>` v4l2\_fourcc('b', 'G', 'A', '8')
    \#define \ :ref:`V4L2_PIX_FMT_SGRBG10DPCM8 <v4l2-pix-fmt-sgrbg10dpcm8>` v4l2\_fourcc('B', 'D', '1', '0')
    \#define \ :ref:`V4L2_PIX_FMT_SRGGB10DPCM8 <v4l2-pix-fmt-srggb10dpcm8>` v4l2\_fourcc('b', 'R', 'A', '8')
    \#define \ :ref:`V4L2_PIX_FMT_SBGGR12 <v4l2-pix-fmt-sbggr12>` v4l2\_fourcc('B', 'G', '1', '2') \/\* 12  BGBG.. GRGR.. \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SGBRG12 <v4l2-pix-fmt-sgbrg12>` v4l2\_fourcc('G', 'B', '1', '2') \/\* 12  GBGB.. RGRG.. \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SGRBG12 <v4l2-pix-fmt-sgrbg12>` v4l2\_fourcc('B', 'A', '1', '2') \/\* 12  GRGR.. BGBG.. \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SRGGB12 <v4l2-pix-fmt-srggb12>` v4l2\_fourcc('R', 'G', '1', '2') \/\* 12  RGRG.. GBGB.. \*\/
            \/\* 12bit raw bayer packed, 6 bytes for every 4 pixels \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SBGGR12P <v4l2-pix-fmt-sbggr12p>` v4l2\_fourcc('p', 'B', 'C', 'C')
    \#define \ :ref:`V4L2_PIX_FMT_SGBRG12P <v4l2-pix-fmt-sgbrg12p>` v4l2\_fourcc('p', 'G', 'C', 'C')
    \#define \ :ref:`V4L2_PIX_FMT_SGRBG12P <v4l2-pix-fmt-sgrbg12p>` v4l2\_fourcc('p', 'g', 'C', 'C')
    \#define \ :ref:`V4L2_PIX_FMT_SRGGB12P <v4l2-pix-fmt-srggb12p>` v4l2\_fourcc('p', 'R', 'C', 'C')
    \#define \ :ref:`V4L2_PIX_FMT_SBGGR14 <v4l2-pix-fmt-sbggr14>` v4l2\_fourcc('B', 'G', '1', '4') \/\* 14  BGBG.. GRGR.. \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SGBRG14 <v4l2-pix-fmt-sgbrg14>` v4l2\_fourcc('G', 'B', '1', '4') \/\* 14  GBGB.. RGRG.. \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SGRBG14 <v4l2-pix-fmt-sgrbg14>` v4l2\_fourcc('G', 'R', '1', '4') \/\* 14  GRGR.. BGBG.. \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SRGGB14 <v4l2-pix-fmt-srggb14>` v4l2\_fourcc('R', 'G', '1', '4') \/\* 14  RGRG.. GBGB.. \*\/
            \/\* 14bit raw bayer packed, 7 bytes for every 4 pixels \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SBGGR14P <v4l2-pix-fmt-sbggr14p>` v4l2\_fourcc('p', 'B', 'E', 'E')
    \#define \ :ref:`V4L2_PIX_FMT_SGBRG14P <v4l2-pix-fmt-sgbrg14p>` v4l2\_fourcc('p', 'G', 'E', 'E')
    \#define \ :ref:`V4L2_PIX_FMT_SGRBG14P <v4l2-pix-fmt-sgrbg14p>` v4l2\_fourcc('p', 'g', 'E', 'E')
    \#define \ :ref:`V4L2_PIX_FMT_SRGGB14P <v4l2-pix-fmt-srggb14p>` v4l2\_fourcc('p', 'R', 'E', 'E')
    \#define \ :ref:`V4L2_PIX_FMT_SBGGR16 <v4l2-pix-fmt-sbggr16>` v4l2\_fourcc('B', 'Y', 'R', '2') \/\* 16  BGBG.. GRGR.. \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SGBRG16 <v4l2-pix-fmt-sgbrg16>` v4l2\_fourcc('G', 'B', '1', '6') \/\* 16  GBGB.. RGRG.. \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SGRBG16 <v4l2-pix-fmt-sgrbg16>` v4l2\_fourcc('G', 'R', '1', '6') \/\* 16  GRGR.. BGBG.. \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SRGGB16 <v4l2-pix-fmt-srggb16>` v4l2\_fourcc('R', 'G', '1', '6') \/\* 16  RGRG.. GBGB.. \*\/

    \/\* HSV formats \*\/
    \#define \ :ref:`V4L2_PIX_FMT_HSV24 <v4l2-pix-fmt-hsv24>` v4l2\_fourcc('H', 'S', 'V', '3')
    \#define \ :ref:`V4L2_PIX_FMT_HSV32 <v4l2-pix-fmt-hsv32>` v4l2\_fourcc('H', 'S', 'V', '4')

    \/\* compressed formats \*\/
    \#define \ :ref:`V4L2_PIX_FMT_MJPEG <v4l2-pix-fmt-mjpeg>`    v4l2\_fourcc('M', 'J', 'P', 'G') \/\* Motion-JPEG   \*\/
    \#define \ :ref:`V4L2_PIX_FMT_JPEG <v4l2-pix-fmt-jpeg>`     v4l2\_fourcc('J', 'P', 'E', 'G') \/\* JFIF JPEG     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_DV <v4l2-pix-fmt-dv>`       v4l2\_fourcc('d', 'v', 's', 'd') \/\* 1394          \*\/
    \#define \ :ref:`V4L2_PIX_FMT_MPEG <v4l2-pix-fmt-mpeg>`     v4l2\_fourcc('M', 'P', 'E', 'G') \/\* MPEG-1\/2\/4 Multiplexed \*\/
    \#define \ :ref:`V4L2_PIX_FMT_H264 <v4l2-pix-fmt-h264>`     v4l2\_fourcc('H', '2', '6', '4') \/\* H264 with start codes \*\/
    \#define \ :ref:`V4L2_PIX_FMT_H264_NO_SC <v4l2-pix-fmt-h264-no-sc>` v4l2\_fourcc('A', 'V', 'C', '1') \/\* H264 without start codes \*\/
    \#define \ :ref:`V4L2_PIX_FMT_H264_MVC <v4l2-pix-fmt-h264-mvc>` v4l2\_fourcc('M', '2', '6', '4') \/\* H264 MVC \*\/
    \#define \ :ref:`V4L2_PIX_FMT_H263 <v4l2-pix-fmt-h263>`     v4l2\_fourcc('H', '2', '6', '3') \/\* H263          \*\/
    \#define \ :ref:`V4L2_PIX_FMT_MPEG1 <v4l2-pix-fmt-mpeg1>`    v4l2\_fourcc('M', 'P', 'G', '1') \/\* MPEG-1 ES     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_MPEG2 <v4l2-pix-fmt-mpeg2>`    v4l2\_fourcc('M', 'P', 'G', '2') \/\* MPEG-2 ES     \*\/
    \#define \ :ref:`V4L2_PIX_FMT_MPEG2_SLICE <v4l2-pix-fmt-mpeg2-slice>` v4l2\_fourcc('M', 'G', '2', 'S') \/\* MPEG-2 parsed slice data \*\/
    \#define \ :ref:`V4L2_PIX_FMT_MPEG4 <v4l2-pix-fmt-mpeg4>`    v4l2\_fourcc('M', 'P', 'G', '4') \/\* MPEG-4 part 2 ES \*\/
    \#define \ :ref:`V4L2_PIX_FMT_XVID <v4l2-pix-fmt-xvid>`     v4l2\_fourcc('X', 'V', 'I', 'D') \/\* Xvid           \*\/
    \#define \ :ref:`V4L2_PIX_FMT_VC1_ANNEX_G <v4l2-pix-fmt-vc1-annex-g>` v4l2\_fourcc('V', 'C', '1', 'G') \/\* SMPTE 421M Annex G compliant stream \*\/
    \#define \ :ref:`V4L2_PIX_FMT_VC1_ANNEX_L <v4l2-pix-fmt-vc1-annex-l>` v4l2\_fourcc('V', 'C', '1', 'L') \/\* SMPTE 421M Annex L compliant stream \*\/
    \#define \ :ref:`V4L2_PIX_FMT_VP8 <v4l2-pix-fmt-vp8>`      v4l2\_fourcc('V', 'P', '8', '0') \/\* VP8 \*\/
    \#define \ :ref:`V4L2_PIX_FMT_VP9 <v4l2-pix-fmt-vp9>`      v4l2\_fourcc('V', 'P', '9', '0') \/\* VP9 \*\/
    \#define \ :ref:`V4L2_PIX_FMT_HEVC <v4l2-pix-fmt-hevc>`     v4l2\_fourcc('H', 'E', 'V', 'C') \/\* HEVC aka H.265 \*\/
    \#define \ :ref:`V4L2_PIX_FMT_FWHT <v4l2-pix-fmt-fwht>`     v4l2\_fourcc('F', 'W', 'H', 'T') \/\* Fast Walsh Hadamard Transform (vicodec) \*\/
    \#define \ :ref:`V4L2_PIX_FMT_FWHT_STATELESS <v4l2-pix-fmt-fwht-stateless>`     v4l2\_fourcc('S', 'F', 'W', 'H') \/\* Stateless FWHT (vicodec) \*\/

    \/\*  Vendor-specific formats   \*\/
    \#define \ :ref:`V4L2_PIX_FMT_CPIA1 <v4l2-pix-fmt-cpia1>`    v4l2\_fourcc('C', 'P', 'I', 'A') \/\* cpia1 YUV \*\/
    \#define \ :ref:`V4L2_PIX_FMT_WNVA <v4l2-pix-fmt-wnva>`     v4l2\_fourcc('W', 'N', 'V', 'A') \/\* Winnov hw compress \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SN9C10X <v4l2-pix-fmt-sn9c10x>`  v4l2\_fourcc('S', '9', '1', '0') \/\* SN9C10x compression \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SN9C20X_I420 <v4l2-pix-fmt-sn9c20x-i420>` v4l2\_fourcc('S', '9', '2', '0') \/\* SN9C20x YUV 4\:2\:0 \*\/
    \#define \ :ref:`V4L2_PIX_FMT_PWC1 <v4l2-pix-fmt-pwc1>`     v4l2\_fourcc('P', 'W', 'C', '1') \/\* pwc older webcam \*\/
    \#define \ :ref:`V4L2_PIX_FMT_PWC2 <v4l2-pix-fmt-pwc2>`     v4l2\_fourcc('P', 'W', 'C', '2') \/\* pwc newer webcam \*\/
    \#define \ :ref:`V4L2_PIX_FMT_ET61X251 <v4l2-pix-fmt-et61x251>` v4l2\_fourcc('E', '6', '2', '5') \/\* ET61X251 compression \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SPCA501 <v4l2-pix-fmt-spca501>`  v4l2\_fourcc('S', '5', '0', '1') \/\* YUYV per line \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SPCA505 <v4l2-pix-fmt-spca505>`  v4l2\_fourcc('S', '5', '0', '5') \/\* YYUV per line \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SPCA508 <v4l2-pix-fmt-spca508>`  v4l2\_fourcc('S', '5', '0', '8') \/\* YUVY per line \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SPCA561 <v4l2-pix-fmt-spca561>`  v4l2\_fourcc('S', '5', '6', '1') \/\* compressed GBRG bayer \*\/
    \#define \ :ref:`V4L2_PIX_FMT_PAC207 <v4l2-pix-fmt-pac207>`   v4l2\_fourcc('P', '2', '0', '7') \/\* compressed BGGR bayer \*\/
    \#define \ :ref:`V4L2_PIX_FMT_MR97310A <v4l2-pix-fmt-mr97310a>` v4l2\_fourcc('M', '3', '1', '0') \/\* compressed BGGR bayer \*\/
    \#define \ :ref:`V4L2_PIX_FMT_JL2005BCD <v4l2-pix-fmt-jl2005bcd>` v4l2\_fourcc('J', 'L', '2', '0') \/\* compressed RGGB bayer \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SN9C2028 <v4l2-pix-fmt-sn9c2028>` v4l2\_fourcc('S', 'O', 'N', 'X') \/\* compressed GBRG bayer \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SQ905C <v4l2-pix-fmt-sq905c>`   v4l2\_fourcc('9', '0', '5', 'C') \/\* compressed RGGB bayer \*\/
    \#define \ :ref:`V4L2_PIX_FMT_PJPG <v4l2-pix-fmt-pjpg>`     v4l2\_fourcc('P', 'J', 'P', 'G') \/\* Pixart 73xx JPEG \*\/
    \#define \ :ref:`V4L2_PIX_FMT_OV511 <v4l2-pix-fmt-ov511>`    v4l2\_fourcc('O', '5', '1', '1') \/\* ov511 JPEG \*\/
    \#define \ :ref:`V4L2_PIX_FMT_OV518 <v4l2-pix-fmt-ov518>`    v4l2\_fourcc('O', '5', '1', '8') \/\* ov518 JPEG \*\/
    \#define \ :ref:`V4L2_PIX_FMT_STV0680 <v4l2-pix-fmt-stv0680>`  v4l2\_fourcc('S', '6', '8', '0') \/\* stv0680 bayer \*\/
    \#define \ :ref:`V4L2_PIX_FMT_TM6000 <v4l2-pix-fmt-tm6000>`   v4l2\_fourcc('T', 'M', '6', '0') \/\* tm5600\/tm60x0 \*\/
    \#define \ :ref:`V4L2_PIX_FMT_CIT_YYVYUY <v4l2-pix-fmt-cit-yyvyuy>` v4l2\_fourcc('C', 'I', 'T', 'V') \/\* one line of Y then 1 line of VYUY \*\/
    \#define \ :ref:`V4L2_PIX_FMT_KONICA420 <v4l2-pix-fmt-konica420>`  v4l2\_fourcc('K', 'O', 'N', 'I') \/\* YUV420 planar in blocks of 256 pixels \*\/
    \#define \ :ref:`V4L2_PIX_FMT_JPGL <v4l2-pix-fmt-jpgl>`       v4l2\_fourcc('J', 'P', 'G', 'L') \/\* JPEG-Lite \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SE401 <v4l2-pix-fmt-se401>`      v4l2\_fourcc('S', '4', '0', '1') \/\* se401 janggu compressed rgb \*\/
    \#define \ :ref:`V4L2_PIX_FMT_S5C_UYVY_JPG <v4l2-pix-fmt-s5c-uyvy-jpg>` v4l2\_fourcc('S', '5', 'C', 'I') \/\* S5C73M3 interleaved UYVY\/JPEG \*\/
    \#define \ :ref:`V4L2_PIX_FMT_Y8I <v4l2-pix-fmt-y8i>`      v4l2\_fourcc('Y', '8', 'I', ' ') \/\* Greyscale 8-bit L\/R interleaved \*\/
    \#define \ :ref:`V4L2_PIX_FMT_Y12I <v4l2-pix-fmt-y12i>`     v4l2\_fourcc('Y', '1', '2', 'I') \/\* Greyscale 12-bit L\/R interleaved \*\/
    \#define \ :ref:`V4L2_PIX_FMT_Z16 <v4l2-pix-fmt-z16>`      v4l2\_fourcc('Z', '1', '6', ' ') \/\* Depth data 16-bit \*\/
    \#define \ :ref:`V4L2_PIX_FMT_MT21C <v4l2-pix-fmt-mt21c>`    v4l2\_fourcc('M', 'T', '2', '1') \/\* Mediatek compressed block mode  \*\/
    \#define \ :ref:`V4L2_PIX_FMT_INZI <v4l2-pix-fmt-inzi>`     v4l2\_fourcc('I', 'N', 'Z', 'I') \/\* Intel Planar Greyscale 10-bit and Depth 16-bit \*\/
    \#define \ :ref:`V4L2_PIX_FMT_SUNXI_TILED_NV12 <v4l2-pix-fmt-sunxi-tiled-nv12>` v4l2\_fourcc('S', 'T', '1', '2') \/\* Sunxi Tiled NV12 Format \*\/
    \#define \ :ref:`V4L2_PIX_FMT_CNF4 <v4l2-pix-fmt-cnf4>`     v4l2\_fourcc('C', 'N', 'F', '4') \/\* Intel 4-bit packed depth confidence information \*\/

    \/\* 10bit raw bayer packed, 32 bytes for every 25 pixels, last LSB 6 bits unused \*\/
    \#define \ :ref:`V4L2_PIX_FMT_IPU3_SBGGR10 <v4l2-pix-fmt-ipu3-sbggr10>`       v4l2\_fourcc('i', 'p', '3', 'b') \/\* IPU3 packed 10-bit BGGR bayer \*\/
    \#define \ :ref:`V4L2_PIX_FMT_IPU3_SGBRG10 <v4l2-pix-fmt-ipu3-sgbrg10>`       v4l2\_fourcc('i', 'p', '3', 'g') \/\* IPU3 packed 10-bit GBRG bayer \*\/
    \#define \ :ref:`V4L2_PIX_FMT_IPU3_SGRBG10 <v4l2-pix-fmt-ipu3-sgrbg10>`       v4l2\_fourcc('i', 'p', '3', 'G') \/\* IPU3 packed 10-bit GRBG bayer \*\/
    \#define \ :ref:`V4L2_PIX_FMT_IPU3_SRGGB10 <v4l2-pix-fmt-ipu3-srggb10>`       v4l2\_fourcc('i', 'p', '3', 'r') \/\* IPU3 packed 10-bit RGGB bayer \*\/

    \/\* SDR formats - used only for Software Defined Radio devices \*\/
    \#define \ :ref:`V4L2_SDR_FMT_CU8 <v4l2-sdr-fmt-cu8>`          v4l2\_fourcc('C', 'U', '0', '8') \/\* IQ u8 \*\/
    \#define \ :ref:`V4L2_SDR_FMT_CU16LE <v4l2-sdr-fmt-cu16le>`       v4l2\_fourcc('C', 'U', '1', '6') \/\* IQ u16le \*\/
    \#define \ :ref:`V4L2_SDR_FMT_CS8 <v4l2-sdr-fmt-cs8>`          v4l2\_fourcc('C', 'S', '0', '8') \/\* complex s8 \*\/
    \#define \ :ref:`V4L2_SDR_FMT_CS14LE <v4l2-sdr-fmt-cs14le>`       v4l2\_fourcc('C', 'S', '1', '4') \/\* complex s14le \*\/
    \#define \ :ref:`V4L2_SDR_FMT_RU12LE <v4l2-sdr-fmt-ru12le>`       v4l2\_fourcc('R', 'U', '1', '2') \/\* real u12le \*\/
    \#define \ :ref:`V4L2_SDR_FMT_PCU16BE <v4l2-sdr-fmt-pcu16be>`      v4l2\_fourcc('P', 'C', '1', '6') \/\* planar complex u16be \*\/
    \#define \ :ref:`V4L2_SDR_FMT_PCU18BE <v4l2-sdr-fmt-pcu18be>`      v4l2\_fourcc('P', 'C', '1', '8') \/\* planar complex u18be \*\/
    \#define \ :ref:`V4L2_SDR_FMT_PCU20BE <v4l2-sdr-fmt-pcu20be>`      v4l2\_fourcc('P', 'C', '2', '0') \/\* planar complex u20be \*\/

    \/\* Touch formats - used for Touch devices \*\/
    \#define \ :ref:`V4L2_TCH_FMT_DELTA_TD16 <v4l2-tch-fmt-delta-td16>` v4l2\_fourcc('T', 'D', '1', '6') \/\* 16-bit signed deltas \*\/
    \#define \ :ref:`V4L2_TCH_FMT_DELTA_TD08 <v4l2-tch-fmt-delta-td08>` v4l2\_fourcc('T', 'D', '0', '8') \/\* 8-bit signed deltas \*\/
    \#define \ :ref:`V4L2_TCH_FMT_TU16 <v4l2-tch-fmt-tu16>`       v4l2\_fourcc('T', 'U', '1', '6') \/\* 16-bit unsigned touch data \*\/
    \#define \ :ref:`V4L2_TCH_FMT_TU08 <v4l2-tch-fmt-tu08>`       v4l2\_fourcc('T', 'U', '0', '8') \/\* 8-bit unsigned touch data \*\/

    \/\* Meta-data formats \*\/
    \#define \ :ref:`V4L2_META_FMT_VSP1_HGO <v4l2-meta-fmt-vsp1-hgo>`    v4l2\_fourcc('V', 'S', 'P', 'H') \/\* R-Car VSP1 1-D Histogram \*\/
    \#define \ :ref:`V4L2_META_FMT_VSP1_HGT <v4l2-meta-fmt-vsp1-hgt>`    v4l2\_fourcc('V', 'S', 'P', 'T') \/\* R-Car VSP1 2-D Histogram \*\/
    \#define \ :ref:`V4L2_META_FMT_UVC <v4l2-meta-fmt-uvc>`         v4l2\_fourcc('U', 'V', 'C', 'H') \/\* UVC Payload Header metadata \*\/
    \#define \ :ref:`V4L2_META_FMT_D4XX <v4l2-meta-fmt-d4xx>`        v4l2\_fourcc('D', '4', 'X', 'X') \/\* D4XX Payload Header metadata \*\/
    \#define \ :ref:`V4L2_META_FMT_VIVID <v4l2-meta-fmt-vivid>`       v4l2\_fourcc('V', 'I', 'V', 'D') \/\* Vivid Metadata \*\/

    \/\* priv field value to indicates that subsequent fields are valid. \*\/
    \#define :c:type:`V4L2_PIX_FMT_PRIV_MAGIC <v4l2_pix_format>`         0xfeedcafe

    \/\* Flags \*\/
    \#define :ref:`V4L2_PIX_FMT_FLAG_PREMUL_ALPHA <format-flags>`  0x00000001
    \#define \ :ref:`V4L2_PIX_FMT_FLAG_SET_CSC <v4l2-pix-fmt-flag-set-csc>`       0x00000002

    \/\*
     \*      F O R M A T   E N U M E R A T I O N
     \*\/
    struct v4l2_fmtdesc \{
            \_\_u32               index;             \/\* Format number      \*\/
            \_\_u32               type;              \/\* enum :c:type:`v4l2_buf_type` \*\/
            \_\_u32               flags;
            \_\_u8                description[32];   \/\* Description string \*\/
            \_\_u32               pixelformat;       \/\* Format fourcc      \*\/
            \_\_u32               mbus\_code;          \/\* Media bus code    \*\/
            \_\_u32               reserved[3];
    \};

    \#define :ref:`V4L2_FMT_FLAG_COMPRESSED <fmtdesc-flags>`                0x0001
    \#define :ref:`V4L2_FMT_FLAG_EMULATED <fmtdesc-flags>`                  0x0002
    \#define :ref:`V4L2_FMT_FLAG_CONTINUOUS_BYTESTREAM <fmtdesc-flags>`     0x0004
    \#define :ref:`V4L2_FMT_FLAG_DYN_RESOLUTION <fmtdesc-flags>`            0x0008
    \#define :ref:`V4L2_FMT_FLAG_ENC_CAP_FRAME_INTERVAL <fmtdesc-flags>`    0x0010
    \#define :ref:`V4L2_FMT_FLAG_CSC_COLORSPACE <fmtdesc-flags>`            0x0020
    \#define :ref:`V4L2_FMT_FLAG_CSC_XFER_FUNC <fmtdesc-flags>`             0x0040
    \#define :ref:`V4L2_FMT_FLAG_CSC_YCBCR_ENC <fmtdesc-flags>`             0x0080
    \#define :ref:`V4L2_FMT_FLAG_CSC_HSV_ENC <fmtdesc-flags>`               :ref:`V4L2_FMT_FLAG_CSC_YCBCR_ENC <fmtdesc-flags>`
    \#define :ref:`V4L2_FMT_FLAG_CSC_QUANTIZATION <fmtdesc-flags>`          0x0100

            \/\* Frame Size and frame rate enumeration \*\/
    \/\*
     \*      F R A M E   S I Z E   E N U M E R A T I O N
     \*\/
    enum :c:type:`v4l2_frmsizetypes` \{
            :c:type:`V4L2_FRMSIZE_TYPE_DISCRETE <v4l2_frmsizetypes>`      = 1,
            :c:type:`V4L2_FRMSIZE_TYPE_CONTINUOUS <v4l2_frmsizetypes>`    = 2,
            :c:type:`V4L2_FRMSIZE_TYPE_STEPWISE <v4l2_frmsizetypes>`      = 3,
    \};

    struct v4l2_frmsize_discrete \{
            \_\_u32                   width;          \/\* Frame width [pixel] \*\/
            \_\_u32                   height;         \/\* Frame height [pixel] \*\/
    \};

    struct v4l2_frmsize_stepwise \{
            \_\_u32                   min\_width;      \/\* Minimum frame width [pixel] \*\/
            \_\_u32                   max\_width;      \/\* Maximum frame width [pixel] \*\/
            \_\_u32                   step\_width;     \/\* Frame width step size [pixel] \*\/
            \_\_u32                   min\_height;     \/\* Minimum frame height [pixel] \*\/
            \_\_u32                   max\_height;     \/\* Maximum frame height [pixel] \*\/
            \_\_u32                   step\_height;    \/\* Frame height step size [pixel] \*\/
    \};

    struct v4l2_frmsizeenum \{
            \_\_u32                   index;          \/\* Frame size number \*\/
            \_\_u32                   pixel\_format;   \/\* Pixel format \*\/
            \_\_u32                   type;           \/\* Frame size type the device supports. \*\/

            union \{                                 \/\* Frame size \*\/
                    struct v4l2_frmsize_discrete    discrete;
                    struct v4l2_frmsize_stepwise    stepwise;
            \};

            \_\_u32   reserved[2];                    \/\* Reserved space for future use \*\/
    \};

    \/\*
     \*      F R A M E   R A T E   E N U M E R A T I O N
     \*\/
    enum :c:type:`v4l2_frmivaltypes` \{
            :c:type:`V4L2_FRMIVAL_TYPE_DISCRETE <v4l2_frmivaltypes>`      = 1,
            :c:type:`V4L2_FRMIVAL_TYPE_CONTINUOUS <v4l2_frmivaltypes>`    = 2,
            :c:type:`V4L2_FRMIVAL_TYPE_STEPWISE <v4l2_frmivaltypes>`      = 3,
    \};

    struct v4l2_frmival_stepwise \{
            struct v4l2_fract       min;            \/\* Minimum frame interval [s] \*\/
            struct v4l2_fract       max;            \/\* Maximum frame interval [s] \*\/
            struct v4l2_fract       step;           \/\* Frame interval step size [s] \*\/
    \};

    struct v4l2_frmivalenum \{
            \_\_u32                   index;          \/\* Frame format index \*\/
            \_\_u32                   pixel\_format;   \/\* Pixel format \*\/
            \_\_u32                   width;          \/\* Frame width \*\/
            \_\_u32                   height;         \/\* Frame height \*\/
            \_\_u32                   type;           \/\* Frame interval type the device supports. \*\/

            union \{                                 \/\* Frame interval \*\/
                    struct v4l2_fract               discrete;
                    struct v4l2_frmival_stepwise    stepwise;
            \};

            \_\_u32   reserved[2];                    \/\* Reserved space for future use \*\/
    \};

    \/\*
     \*      T I M E C O D E
     \*\/
    struct v4l2_timecode \{
            \_\_u32   type;
            \_\_u32   flags;
            \_\_u8    frames;
            \_\_u8    seconds;
            \_\_u8    minutes;
            \_\_u8    hours;
            \_\_u8    userbits[4];
    \};

    \/\*  Type  \*\/
    \#define :ref:`V4L2_TC_TYPE_24FPS <timecode-type>`              1
    \#define :ref:`V4L2_TC_TYPE_25FPS <timecode-type>`              2
    \#define :ref:`V4L2_TC_TYPE_30FPS <timecode-type>`              3
    \#define :ref:`V4L2_TC_TYPE_50FPS <timecode-type>`              4
    \#define :ref:`V4L2_TC_TYPE_60FPS <timecode-type>`              5

    \/\*  Flags  \*\/
    \#define :ref:`V4L2_TC_FLAG_DROPFRAME <timecode-flags>`          0x0001 \/\* "drop-frame" mode \*\/
    \#define :ref:`V4L2_TC_FLAG_COLORFRAME <timecode-flags>`         0x0002
    \#define :ref:`V4L2_TC_USERBITS_field <timecode-flags>`          0x000C
    \#define :ref:`V4L2_TC_USERBITS_USERDEFINED <timecode-flags>`    0x0000
    \#define :ref:`V4L2_TC_USERBITS_8BITCHARS <timecode-flags>`      0x0008
    \/\* The above is based on SMPTE timecodes \*\/

    struct v4l2_jpegcompression \{
            int quality;

            int  APPn;              \/\* Number of APP segment to be written,
                                     \* must be 0..15 \*\/
            int  APP\_len;           \/\* Length of data in JPEG APPn segment \*\/
            char APP\_data[60];      \/\* Data in the JPEG APPn segment. \*\/

            int  COM\_len;           \/\* Length of data in JPEG COM segment \*\/
            char COM\_data[60];      \/\* Data in JPEG COM segment \*\/

            \_\_u32 jpeg\_markers;     \/\* Which markers should go into the JPEG
                                     \* output. Unless you exactly know what
                                     \* you do, leave them untouched.
                                     \* Including less markers will make the
                                     \* resulting code smaller, but there will
                                     \* be fewer applications which can read it.
                                     \* The presence of the APP and COM marker
                                     \* is influenced by APP\_len and COM\_len
                                     \* ONLY, not by this property! \*\/

    \#define :ref:`V4L2_JPEG_MARKER_DHT <jpeg-markers>` (1\<\<3)    \/\* Define Huffman Tables \*\/
    \#define :ref:`V4L2_JPEG_MARKER_DQT <jpeg-markers>` (1\<\<4)    \/\* Define Quantization Tables \*\/
    \#define :ref:`V4L2_JPEG_MARKER_DRI <jpeg-markers>` (1\<\<5)    \/\* Define Restart Interval \*\/
    \#define :ref:`V4L2_JPEG_MARKER_COM <jpeg-markers>` (1\<\<6)    \/\* Comment segment \*\/
    \#define :ref:`V4L2_JPEG_MARKER_APP <jpeg-markers>` (1\<\<7)    \/\* App segment, driver will
                                            \* always use APP0 \*\/
    \};

    \/\*
     \*      M E M O R Y - M A P P I N G   B U F F E R S
     \*\/

    \#ifdef \_\_KERNEL\_\_
    \/\*
     \* This corresponds to the user space version of timeval
     \* for 64-bit time\_t. sparc64 is different from everyone
     \* else, using the microseconds in the wrong half of the
     \* second 64-bit word.
     \*\/
    struct __kernel_v4l2_timeval \{
            long long       tv\_sec;
    \#if defined(\_\_sparc\_\_) \&\& defined(\_\_arch64\_\_)
            int             tv\_usec;
            int             \_\_pad;
    \#else
            long long       tv\_usec;
    \#endif
    \};
    \#endif

    struct v4l2_requestbuffers \{
            \_\_u32                   count;
            \_\_u32                   type;           \/\* enum :c:type:`v4l2_buf_type` \*\/
            \_\_u32                   memory;         \/\* enum :c:type:`v4l2_memory` \*\/
            \_\_u32                   capabilities;
            \_\_u32                   reserved[1];
    \};

    \/\* capabilities for struct v4l2_requestbuffers and v4l2\_create\_buffers \*\/
    \#define \ :ref:`V4L2_BUF_CAP_SUPPORTS_MMAP <v4l2-buf-cap-supports-mmap>`                      (1 \<\< 0)
    \#define \ :ref:`V4L2_BUF_CAP_SUPPORTS_USERPTR <v4l2-buf-cap-supports-userptr>`                   (1 \<\< 1)
    \#define \ :ref:`V4L2_BUF_CAP_SUPPORTS_DMABUF <v4l2-buf-cap-supports-dmabuf>`                    (1 \<\< 2)
    \#define \ :ref:`V4L2_BUF_CAP_SUPPORTS_REQUESTS <v4l2-buf-cap-supports-requests>`                  (1 \<\< 3)
    \#define \ :ref:`V4L2_BUF_CAP_SUPPORTS_ORPHANED_BUFS <v4l2-buf-cap-supports-orphaned-bufs>`             (1 \<\< 4)
    \#define \ :ref:`V4L2_BUF_CAP_SUPPORTS_M2M_HOLD_CAPTURE_BUF <v4l2-buf-cap-supports-m2m-hold-capture-buf>`      (1 \<\< 5)
    \#define \ :ref:`V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS <v4l2-buf-cap-supports-mmap-cache-hints>`          (1 \<\< 6)

    \/\*\*
     \* struct v4l2_plane - plane info for multi-planar buffers
     \* @bytesused\:          number of bytes occupied by data in the plane (payload)
     \* @length\:             size of this plane (NOT the payload) in bytes
     \* @mem\_offset\:         when memory in the associated struct v4l2_buffer is
     \*                      :c:type:`V4L2_MEMORY_MMAP <v4l2_memory>`, equals the offset from the start of
     \*                      the device memory for this plane (or is a "cookie" that
     \*                      should be passed to mmap() called on the video node)
     \* @userptr\:            when memory is :c:type:`V4L2_MEMORY_USERPTR <v4l2_memory>`, a userspace pointer
     \*                      pointing to this plane
     \* @fd\:                 when memory is :c:type:`V4L2_MEMORY_DMABUF <v4l2_memory>`, a userspace file
     \*                      descriptor associated with this plane
     \* @data\_offset\:        offset in the plane to the start of data; usually 0,
     \*                      unless there is a header in front of the data
     \*
     \* Multi-planar buffers consist of one or more planes, e.g. an YCbCr buffer
     \* with two planes can have one plane for Y, and another for interleaved CbCr
     \* components. Each plane can reside in a separate memory buffer, or even in
     \* a completely separate memory node (e.g. in embedded devices).
     \*\/
    struct v4l2_plane \{
            \_\_u32                   bytesused;
            \_\_u32                   length;
            union \{
                    \_\_u32           mem\_offset;
                    unsigned long   userptr;
                    \_\_s32           fd;
            \} m;
            \_\_u32                   data\_offset;
            \_\_u32                   reserved[11];
    \};

    \/\*\*
     \* struct v4l2_buffer - video buffer info
     \* @index\:      id number of the buffer
     \* @type\:       enum :c:type:`v4l2_buf_type`\ ; buffer type (type == \*\_MPLANE for
     \*              multiplanar buffers);
     \* @bytesused\:  number of bytes occupied by data in the buffer (payload);
     \*              unused (set to 0) for multiplanar buffers
     \* @flags\:      buffer informational flags
     \* @field\:      enum :c:type:`v4l2_field`\ ; field order of the image in the buffer
     \* @timestamp\:  frame timestamp
     \* @timecode\:   frame timecode
     \* @sequence\:   sequence count of this frame
     \* @memory\:     enum :c:type:`v4l2_memory`\ ; the method, in which the actual video data is
     \*              passed
     \* @offset\:     for non-multiplanar buffers with memory == :c:type:`V4L2_MEMORY_MMAP <v4l2_memory>`;
     \*              offset from the start of the device memory for this plane,
     \*              (or a "cookie" that should be passed to mmap() as offset)
     \* @userptr\:    for non-multiplanar buffers with memory == :c:type:`V4L2_MEMORY_USERPTR <v4l2_memory>`;
     \*              a userspace pointer pointing to this buffer
     \* @fd\:         for non-multiplanar buffers with memory == :c:type:`V4L2_MEMORY_DMABUF <v4l2_memory>`;
     \*              a userspace file descriptor associated with this buffer
     \* @planes\:     for multiplanar buffers; userspace pointer to the array of plane
     \*              info structs for this buffer
     \* @length\:     size in bytes of the buffer (NOT its payload) for single-plane
     \*              buffers (when type != \*\_MPLANE); number of elements in the
     \*              planes array for multi-plane buffers
     \* @request\_fd\: fd of the request that this buffer should use
     \*
     \* Contains data exchanged by application and driver using one of the Streaming
     \* I\/O methods.
     \*\/
    struct v4l2_buffer \{
            \_\_u32                   index;
            \_\_u32                   type;
            \_\_u32                   bytesused;
            \_\_u32                   flags;
            \_\_u32                   field;
    \#ifdef \_\_KERNEL\_\_
            struct __kernel_v4l2_timeval timestamp;
    \#else
            struct timeval          timestamp;
    \#endif
            struct v4l2_timecode    timecode;
            \_\_u32                   sequence;

            \/\* memory location \*\/
            \_\_u32                   memory;
            union \{
                    \_\_u32           offset;
                    unsigned long   userptr;
                    struct v4l2_plane \*planes;
                    \_\_s32           fd;
            \} m;
            \_\_u32                   length;
            \_\_u32                   reserved2;
            union \{
                    \_\_s32           request\_fd;
                    \_\_u32           reserved;
            \};
    \};

    \#ifndef \_\_KERNEL\_\_
    \/\*\*
     \* v4l2\_timeval\_to\_ns - Convert timeval to nanoseconds
     \* @ts\:         pointer to the timeval variable to be converted
     \*
     \* Returns the scalar nanosecond representation of the timeval
     \* parameter.
     \*\/
    static inline \_\_u64 v4l2\_timeval\_to\_ns(const struct timeval \*tv)
    \{
            return (\_\_u64)tv-\>tv\_sec \* 1000000000ULL + tv-\>tv\_usec \* 1000;
    \}
    \#endif

    \/\*  Flags for 'flags' field \*\/
    \/\* Buffer is mapped (flag) \*\/
    \#define \ :ref:`V4L2_BUF_FLAG_MAPPED <v4l2-buf-flag-mapped>`                    0x00000001
    \/\* Buffer is queued for processing \*\/
    \#define \ :ref:`V4L2_BUF_FLAG_QUEUED <v4l2-buf-flag-queued>`                    0x00000002
    \/\* Buffer is ready \*\/
    \#define \ :ref:`V4L2_BUF_FLAG_DONE <v4l2-buf-flag-done>`                      0x00000004
    \/\* Image is a keyframe (I-frame) \*\/
    \#define \ :ref:`V4L2_BUF_FLAG_KEYFRAME <v4l2-buf-flag-keyframe>`                  0x00000008
    \/\* Image is a P-frame \*\/
    \#define \ :ref:`V4L2_BUF_FLAG_PFRAME <v4l2-buf-flag-pframe>`                    0x00000010
    \/\* Image is a B-frame \*\/
    \#define \ :ref:`V4L2_BUF_FLAG_BFRAME <v4l2-buf-flag-bframe>`                    0x00000020
    \/\* Buffer is ready, but the data contained within is corrupted. \*\/
    \#define \ :ref:`V4L2_BUF_FLAG_ERROR <v4l2-buf-flag-error>`                     0x00000040
    \/\* Buffer is added to an unqueued request \*\/
    \#define \ :ref:`V4L2_BUF_FLAG_IN_REQUEST <v4l2-buf-flag-in-request>`                0x00000080
    \/\* timecode field is valid \*\/
    \#define \ :ref:`V4L2_BUF_FLAG_TIMECODE <v4l2-buf-flag-timecode>`                  0x00000100
    \/\* Don't return the capture buffer until OUTPUT timestamp changes \*\/
    \#define \ :ref:`V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF <v4l2-buf-flag-m2m-hold-capture-buf>`      0x00000200
    \/\* Buffer is prepared for queuing \*\/
    \#define \ :ref:`V4L2_BUF_FLAG_PREPARED <v4l2-buf-flag-prepared>`                  0x00000400
    \/\* Cache handling flags \*\/
    \#define \ :ref:`V4L2_BUF_FLAG_NO_CACHE_INVALIDATE <v4l2-buf-flag-no-cache-invalidate>`       0x00000800
    \#define \ :ref:`V4L2_BUF_FLAG_NO_CACHE_CLEAN <v4l2-buf-flag-no-cache-clean>`            0x00001000
    \/\* Timestamp type \*\/
    \#define \ :ref:`V4L2_BUF_FLAG_TIMESTAMP_MASK <v4l2-buf-flag-timestamp-mask>`            0x0000e000
    \#define \ :ref:`V4L2_BUF_FLAG_TIMESTAMP_UNKNOWN <v4l2-buf-flag-timestamp-unknown>`         0x00000000
    \#define \ :ref:`V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC <v4l2-buf-flag-timestamp-monotonic>`       0x00002000
    \#define \ :ref:`V4L2_BUF_FLAG_TIMESTAMP_COPY <v4l2-buf-flag-timestamp-copy>`            0x00004000
    \/\* Timestamp sources. \*\/
    \#define \ :ref:`V4L2_BUF_FLAG_TSTAMP_SRC_MASK <v4l2-buf-flag-tstamp-src-mask>`           0x00070000
    \#define \ :ref:`V4L2_BUF_FLAG_TSTAMP_SRC_EOF <v4l2-buf-flag-tstamp-src-eof>`            0x00000000
    \#define \ :ref:`V4L2_BUF_FLAG_TSTAMP_SRC_SOE <v4l2-buf-flag-tstamp-src-soe>`            0x00010000
    \/\* mem2mem encoder\/decoder \*\/
    \#define \ :ref:`V4L2_BUF_FLAG_LAST <v4l2-buf-flag-last>`                      0x00100000
    \/\* request\_fd is valid \*\/
    \#define \ :ref:`V4L2_BUF_FLAG_REQUEST_FD <v4l2-buf-flag-request-fd>`                0x00800000

    \/\*\*
     \* struct v4l2_exportbuffer - export of video buffer as DMABUF file descriptor
     \*
     \* @index\:      id number of the buffer
     \* @type\:       enum :c:type:`v4l2_buf_type`\ ; buffer type (type == \*\_MPLANE for
     \*              multiplanar buffers);
     \* @plane\:      index of the plane to be exported, 0 for single plane queues
     \* @flags\:      flags for newly created file, currently only O\_CLOEXEC is
     \*              supported, refer to manual of open syscall for more details
     \* @fd\:         file descriptor associated with DMABUF (set by driver)
     \*
     \* Contains data used for exporting a video buffer as DMABUF file descriptor.
     \* The buffer is identified by a 'cookie' returned by \ :ref:`VIDIOC_QUERYBUF <vidioc_querybuf>`
     \* (identical to the cookie used to mmap() the buffer to userspace). All
     \* reserved fields must be set to zero. The field reserved0 is expected to
     \* become a structure 'type' allowing an alternative layout of the structure
     \* content. Therefore this field should not be used for any other extensions.
     \*\/
    struct v4l2_exportbuffer \{
            \_\_u32           type; \/\* enum :c:type:`v4l2_buf_type` \*\/
            \_\_u32           index;
            \_\_u32           plane;
            \_\_u32           flags;
            \_\_s32           fd;
            \_\_u32           reserved[11];
    \};

    \/\*
     \*      O V E R L A Y   P R E V I E W
     \*\/
    struct v4l2_framebuffer \{
            \_\_u32                   capability;
            \_\_u32                   flags;
    \/\* FIXME\: in theory we should pass something like PCI device + memory
     \* region + offset instead of some physical address \*\/
            void                    \*base;
            struct \{
                    \_\_u32           width;
                    \_\_u32           height;
                    \_\_u32           pixelformat;
                    \_\_u32           field;          \/\* enum :c:type:`v4l2_field` \*\/
                    \_\_u32           bytesperline;   \/\* for padding, zero if unused \*\/
                    \_\_u32           sizeimage;
                    \_\_u32           colorspace;     \/\* enum :c:type:`v4l2_colorspace` \*\/
                    \_\_u32           priv;           \/\* reserved field, set to 0 \*\/
            \} fmt;
    \};
    \/\*  Flags for the 'capability' field. Read only \*\/
    \#define :ref:`V4L2_FBUF_CAP_EXTERNOVERLAY <framebuffer-cap>`     0x0001
    \#define :ref:`V4L2_FBUF_CAP_CHROMAKEY <framebuffer-cap>`         0x0002
    \#define :ref:`V4L2_FBUF_CAP_LIST_CLIPPING <framebuffer-cap>`     0x0004
    \#define :ref:`V4L2_FBUF_CAP_BITMAP_CLIPPING <framebuffer-cap>`   0x0008
    \#define :ref:`V4L2_FBUF_CAP_LOCAL_ALPHA <framebuffer-cap>`       0x0010
    \#define :ref:`V4L2_FBUF_CAP_GLOBAL_ALPHA <framebuffer-cap>`      0x0020
    \#define :ref:`V4L2_FBUF_CAP_LOCAL_INV_ALPHA <framebuffer-cap>`   0x0040
    \#define :ref:`V4L2_FBUF_CAP_SRC_CHROMAKEY <framebuffer-cap>`     0x0080
    \/\*  Flags for the 'flags' field. \*\/
    \#define :ref:`V4L2_FBUF_FLAG_PRIMARY <framebuffer-flags>`          0x0001
    \#define :ref:`V4L2_FBUF_FLAG_OVERLAY <framebuffer-flags>`          0x0002
    \#define :ref:`V4L2_FBUF_FLAG_CHROMAKEY <framebuffer-flags>`        0x0004
    \#define :ref:`V4L2_FBUF_FLAG_LOCAL_ALPHA <framebuffer-flags>`      0x0008
    \#define :ref:`V4L2_FBUF_FLAG_GLOBAL_ALPHA <framebuffer-flags>`     0x0010
    \#define :ref:`V4L2_FBUF_FLAG_LOCAL_INV_ALPHA <framebuffer-flags>`  0x0020
    \#define :ref:`V4L2_FBUF_FLAG_SRC_CHROMAKEY <framebuffer-flags>`    0x0040

    struct v4l2_clip \{
            struct v4l2_rect        c;
            struct v4l2_clip        \_\_user \*next;
    \};

    struct v4l2_window \{
            struct v4l2_rect        w;
            \_\_u32                   field;   \/\* enum :c:type:`v4l2_field` \*\/
            \_\_u32                   chromakey;
            struct v4l2_clip        \_\_user \*clips;
            \_\_u32                   clipcount;
            void                    \_\_user \*bitmap;
            \_\_u8                    global\_alpha;
    \};

    \/\*
     \*      C A P T U R E   P A R A M E T E R S
     \*\/
    struct v4l2_captureparm \{
            \_\_u32              capability;    \/\*  Supported modes \*\/
            \_\_u32              capturemode;   \/\*  Current mode \*\/
            struct v4l2_fract  timeperframe;  \/\*  Time per frame in seconds \*\/
            \_\_u32              extendedmode;  \/\*  Driver-specific extensions \*\/
            \_\_u32              readbuffers;   \/\*  \# of buffers for read \*\/
            \_\_u32              reserved[4];
    \};

    \/\*  Flags for 'capability' and 'capturemode' fields \*\/
    \#define :ref:`V4L2_MODE_HIGHQUALITY <parm-flags>`   0x0001  \/\*  High quality imaging mode \*\/
    \#define :c:type:`V4L2_CAP_TIMEPERFRAME <v4l2_captureparm>`   0x1000  \/\*  timeperframe field is supported \*\/

    struct v4l2_outputparm \{
            \_\_u32              capability;   \/\*  Supported modes \*\/
            \_\_u32              outputmode;   \/\*  Current mode \*\/
            struct v4l2_fract  timeperframe; \/\*  Time per frame in seconds \*\/
            \_\_u32              extendedmode; \/\*  Driver-specific extensions \*\/
            \_\_u32              writebuffers; \/\*  \# of buffers for write \*\/
            \_\_u32              reserved[4];
    \};

    \/\*
     \*      I N P U T   I M A G E   C R O P P I N G
     \*\/
    struct v4l2_cropcap \{
            \_\_u32                   type;   \/\* enum :c:type:`v4l2_buf_type` \*\/
            struct v4l2_rect        bounds;
            struct v4l2_rect        defrect;
            struct v4l2_fract       pixelaspect;
    \};

    struct v4l2_crop \{
            \_\_u32                   type;   \/\* enum :c:type:`v4l2_buf_type` \*\/
            struct v4l2_rect        c;
    \};

    \/\*\*
     \* struct v4l2_selection - selection info
     \* @type\:       buffer type (do not use \*\_MPLANE types)
     \* @target\:     Selection target, used to choose one of possible rectangles;
     \*              defined in v4l2-common.h; V4L2\_SEL\_TGT\_\* .
     \* @flags\:      constraints flags, defined in v4l2-common.h; V4L2\_SEL\_FLAG\_\*.
     \* @r\:          coordinates of selection window
     \* @reserved\:   for future use, rounds structure size to 64 bytes, set to zero
     \*
     \* Hardware may use multiple helper windows to process a video stream.
     \* The structure is used to exchange this selection areas between
     \* an application and a driver.
     \*\/
    struct v4l2_selection \{
            \_\_u32                   type;
            \_\_u32                   target;
            \_\_u32                   flags;
            struct v4l2_rect        r;
            \_\_u32                   reserved[9];
    \};

    \/\*
     \*      A N A L O G   V I D E O   S T A N D A R D
     \*\/

    typedef \_\_u64 v4l2\_std\_id;

    \/\*
     \* Attention\: Keep the V4L2\_STD\_\* bit definitions in sync with
     \* include\/dt-bindings\/display\/sdtv-standards.h SDTV\_STD\_\* bit definitions.
     \*\/
    \/\* one bit for each \*\/
    \#define :ref:`V4L2_STD_PAL_B <v4l2-std-id>`          ((v4l2\_std\_id)0x00000001)
    \#define :ref:`V4L2_STD_PAL_B1 <v4l2-std-id>`         ((v4l2\_std\_id)0x00000002)
    \#define :ref:`V4L2_STD_PAL_G <v4l2-std-id>`          ((v4l2\_std\_id)0x00000004)
    \#define :ref:`V4L2_STD_PAL_H <v4l2-std-id>`          ((v4l2\_std\_id)0x00000008)
    \#define :ref:`V4L2_STD_PAL_I <v4l2-std-id>`          ((v4l2\_std\_id)0x00000010)
    \#define :ref:`V4L2_STD_PAL_D <v4l2-std-id>`          ((v4l2\_std\_id)0x00000020)
    \#define :ref:`V4L2_STD_PAL_D1 <v4l2-std-id>`         ((v4l2\_std\_id)0x00000040)
    \#define :ref:`V4L2_STD_PAL_K <v4l2-std-id>`          ((v4l2\_std\_id)0x00000080)

    \#define :ref:`V4L2_STD_PAL_M <v4l2-std-id>`          ((v4l2\_std\_id)0x00000100)
    \#define :ref:`V4L2_STD_PAL_N <v4l2-std-id>`          ((v4l2\_std\_id)0x00000200)
    \#define :ref:`V4L2_STD_PAL_Nc <v4l2-std-id>`         ((v4l2\_std\_id)0x00000400)
    \#define :ref:`V4L2_STD_PAL_60 <v4l2-std-id>`         ((v4l2\_std\_id)0x00000800)

    \#define :ref:`V4L2_STD_NTSC_M <v4l2-std-id>`         ((v4l2\_std\_id)0x00001000)       \/\* BTSC \*\/
    \#define :ref:`V4L2_STD_NTSC_M_JP <v4l2-std-id>`      ((v4l2\_std\_id)0x00002000)       \/\* EIA-J \*\/
    \#define :ref:`V4L2_STD_NTSC_443 <v4l2-std-id>`       ((v4l2\_std\_id)0x00004000)
    \#define :ref:`V4L2_STD_NTSC_M_KR <v4l2-std-id>`      ((v4l2\_std\_id)0x00008000)       \/\* FM A2 \*\/

    \#define :ref:`V4L2_STD_SECAM_B <v4l2-std-id>`        ((v4l2\_std\_id)0x00010000)
    \#define :ref:`V4L2_STD_SECAM_D <v4l2-std-id>`        ((v4l2\_std\_id)0x00020000)
    \#define :ref:`V4L2_STD_SECAM_G <v4l2-std-id>`        ((v4l2\_std\_id)0x00040000)
    \#define :ref:`V4L2_STD_SECAM_H <v4l2-std-id>`        ((v4l2\_std\_id)0x00080000)
    \#define :ref:`V4L2_STD_SECAM_K <v4l2-std-id>`        ((v4l2\_std\_id)0x00100000)
    \#define :ref:`V4L2_STD_SECAM_K1 <v4l2-std-id>`       ((v4l2\_std\_id)0x00200000)
    \#define :ref:`V4L2_STD_SECAM_L <v4l2-std-id>`        ((v4l2\_std\_id)0x00400000)
    \#define :ref:`V4L2_STD_SECAM_LC <v4l2-std-id>`       ((v4l2\_std\_id)0x00800000)

    \/\* ATSC\/HDTV \*\/
    \#define :ref:`V4L2_STD_ATSC_8_VSB <v4l2-std-id>`     ((v4l2\_std\_id)0x01000000)
    \#define :ref:`V4L2_STD_ATSC_16_VSB <v4l2-std-id>`    ((v4l2\_std\_id)0x02000000)

    \/\* FIXME\:
       Although std\_id is 64 bits, there is an issue on PPC32 architecture that
       makes switch(\_\_u64) to break. So, there's a hack on v4l2-common.c rounding
       this value to 32 bits.
       As, currently, the max value is for :ref:`V4L2_STD_ATSC_16_VSB <v4l2-std-id>` (30 bits wide),
       it should work fine. However, if needed to add more than two standards,
       v4l2-common.c should be fixed.
     \*\/

    \/\*
     \* Some macros to merge video standards in order to make live easier for the
     \* drivers and V4L2 applications
     \*\/

    \/\*
     \* "Common" NTSC\/M - It should be noticed that :ref:`V4L2_STD_NTSC_443 <v4l2-std-id>` is
     \* Missing here.
     \*\/
    \#define :ref:`V4L2_STD_NTSC <v4l2-std-id>`           (:ref:`V4L2_STD_NTSC_M <v4l2-std-id>`        \|\\
                                     :ref:`V4L2_STD_NTSC_M_JP <v4l2-std-id>`     \|\\
                                     :ref:`V4L2_STD_NTSC_M_KR <v4l2-std-id>`)
    \/\* Secam macros \*\/
    \#define :ref:`V4L2_STD_SECAM_DK <v4l2-std-id>`       (:ref:`V4L2_STD_SECAM_D <v4l2-std-id>`       \|\\
                                     :ref:`V4L2_STD_SECAM_K <v4l2-std-id>`       \|\\
                                     :ref:`V4L2_STD_SECAM_K1 <v4l2-std-id>`)
    \/\* All Secam Standards \*\/
    \#define :ref:`V4L2_STD_SECAM <v4l2-std-id>`          (:ref:`V4L2_STD_SECAM_B <v4l2-std-id>`       \|\\
                                     :ref:`V4L2_STD_SECAM_G <v4l2-std-id>`       \|\\
                                     :ref:`V4L2_STD_SECAM_H <v4l2-std-id>`       \|\\
                                     :ref:`V4L2_STD_SECAM_DK <v4l2-std-id>`      \|\\
                                     :ref:`V4L2_STD_SECAM_L <v4l2-std-id>`       \|\\
                                     :ref:`V4L2_STD_SECAM_LC <v4l2-std-id>`)
    \/\* PAL macros \*\/
    \#define :ref:`V4L2_STD_PAL_BG <v4l2-std-id>`         (:ref:`V4L2_STD_PAL_B <v4l2-std-id>`         \|\\
                                     :ref:`V4L2_STD_PAL_B1 <v4l2-std-id>`        \|\\
                                     :ref:`V4L2_STD_PAL_G <v4l2-std-id>`)
    \#define :ref:`V4L2_STD_PAL_DK <v4l2-std-id>`         (:ref:`V4L2_STD_PAL_D <v4l2-std-id>`         \|\\
                                     :ref:`V4L2_STD_PAL_D1 <v4l2-std-id>`        \|\\
                                     :ref:`V4L2_STD_PAL_K <v4l2-std-id>`)
    \/\*
     \* "Common" PAL - This macro is there to be compatible with the old
     \* V4L1 concept of "PAL"\: \/BGDKHI.
     \* Several PAL standards are missing here\: \/M, \/N and \/Nc
     \*\/
    \#define :ref:`V4L2_STD_PAL <v4l2-std-id>`            (:ref:`V4L2_STD_PAL_BG <v4l2-std-id>`        \|\\
                                     :ref:`V4L2_STD_PAL_DK <v4l2-std-id>`        \|\\
                                     :ref:`V4L2_STD_PAL_H <v4l2-std-id>`         \|\\
                                     :ref:`V4L2_STD_PAL_I <v4l2-std-id>`)
    \/\* Chroma "agnostic" standards \*\/
    \#define :ref:`V4L2_STD_B <v4l2-std-id>`              (:ref:`V4L2_STD_PAL_B <v4l2-std-id>`         \|\\
                                     :ref:`V4L2_STD_PAL_B1 <v4l2-std-id>`        \|\\
                                     :ref:`V4L2_STD_SECAM_B <v4l2-std-id>`)
    \#define :ref:`V4L2_STD_G <v4l2-std-id>`              (:ref:`V4L2_STD_PAL_G <v4l2-std-id>`         \|\\
                                     :ref:`V4L2_STD_SECAM_G <v4l2-std-id>`)
    \#define :ref:`V4L2_STD_H <v4l2-std-id>`              (:ref:`V4L2_STD_PAL_H <v4l2-std-id>`         \|\\
                                     :ref:`V4L2_STD_SECAM_H <v4l2-std-id>`)
    \#define :ref:`V4L2_STD_L <v4l2-std-id>`              (:ref:`V4L2_STD_SECAM_L <v4l2-std-id>`       \|\\
                                     :ref:`V4L2_STD_SECAM_LC <v4l2-std-id>`)
    \#define :ref:`V4L2_STD_GH <v4l2-std-id>`             (:ref:`V4L2_STD_G <v4l2-std-id>`             \|\\
                                     :ref:`V4L2_STD_H <v4l2-std-id>`)
    \#define :ref:`V4L2_STD_DK <v4l2-std-id>`             (:ref:`V4L2_STD_PAL_DK <v4l2-std-id>`        \|\\
                                     :ref:`V4L2_STD_SECAM_DK <v4l2-std-id>`)
    \#define :ref:`V4L2_STD_BG <v4l2-std-id>`             (:ref:`V4L2_STD_B <v4l2-std-id>`             \|\\
                                     :ref:`V4L2_STD_G <v4l2-std-id>`)
    \#define :ref:`V4L2_STD_MN <v4l2-std-id>`             (:ref:`V4L2_STD_PAL_M <v4l2-std-id>`         \|\\
                                     :ref:`V4L2_STD_PAL_N <v4l2-std-id>`         \|\\
                                     :ref:`V4L2_STD_PAL_Nc <v4l2-std-id>`        \|\\
                                     :ref:`V4L2_STD_NTSC <v4l2-std-id>`)

    \/\* Standards where MTS\/BTSC stereo could be found \*\/
    \#define :ref:`V4L2_STD_MTS <v4l2-std-id>`            (:ref:`V4L2_STD_NTSC_M <v4l2-std-id>`        \|\\
                                     :ref:`V4L2_STD_PAL_M <v4l2-std-id>`         \|\\
                                     :ref:`V4L2_STD_PAL_N <v4l2-std-id>`         \|\\
                                     :ref:`V4L2_STD_PAL_Nc <v4l2-std-id>`)

    \/\* Standards for Countries with 60Hz Line frequency \*\/
    \#define :ref:`V4L2_STD_525_60 <v4l2-std-id>`         (:ref:`V4L2_STD_PAL_M <v4l2-std-id>`         \|\\
                                     :ref:`V4L2_STD_PAL_60 <v4l2-std-id>`        \|\\
                                     :ref:`V4L2_STD_NTSC <v4l2-std-id>`          \|\\
                                     :ref:`V4L2_STD_NTSC_443 <v4l2-std-id>`)
    \/\* Standards for Countries with 50Hz Line frequency \*\/
    \#define :ref:`V4L2_STD_625_50 <v4l2-std-id>`         (:ref:`V4L2_STD_PAL <v4l2-std-id>`           \|\\
                                     :ref:`V4L2_STD_PAL_N <v4l2-std-id>`         \|\\
                                     :ref:`V4L2_STD_PAL_Nc <v4l2-std-id>`        \|\\
                                     :ref:`V4L2_STD_SECAM <v4l2-std-id>`)

    \#define :ref:`V4L2_STD_ATSC <v4l2-std-id>`           (:ref:`V4L2_STD_ATSC_8_VSB <v4l2-std-id>`    \|\\
                                     :ref:`V4L2_STD_ATSC_16_VSB <v4l2-std-id>`)
    \/\* Macros with none and all analog standards \*\/
    \#define :ref:`V4L2_STD_UNKNOWN <v4l2-std-id>`        0
    \#define :ref:`V4L2_STD_ALL <v4l2-std-id>`            (:ref:`V4L2_STD_525_60 <v4l2-std-id>`        \|\\
                                     :ref:`V4L2_STD_625_50 <v4l2-std-id>`)

    struct v4l2_standard \{
            \_\_u32                index;
            v4l2\_std\_id          id;
            \_\_u8                 name[24];
            struct v4l2_fract    frameperiod; \/\* Frames, not fields \*\/
            \_\_u32                framelines;
            \_\_u32                reserved[4];
    \};

    \/\*
     \*      D V     B T     T I M I N G S
     \*\/

    \/\*\* struct v4l2_bt_timings - BT.656\/BT.1120 timing data
     \* @width\:      total width of the active video in pixels
     \* @height\:     total height of the active video in lines
     \* @interlaced\: Interlaced or progressive
     \* @polarities\: Positive or negative polarities
     \* @pixelclock\: Pixel clock in HZ. Ex. 74.25MHz-\>74250000
     \* @hfrontporch\:Horizontal front porch in pixels
     \* @hsync\:      Horizontal Sync length in pixels
     \* @hbackporch\: Horizontal back porch in pixels
     \* @vfrontporch\:Vertical front porch in lines
     \* @vsync\:      Vertical Sync length in lines
     \* @vbackporch\: Vertical back porch in lines
     \* @il\_vfrontporch\:Vertical front porch for the even field
     \*              (aka field 2) of interlaced field formats
     \* @il\_vsync\:   Vertical Sync length for the even field
     \*              (aka field 2) of interlaced field formats
     \* @il\_vbackporch\:Vertical back porch for the even field
     \*              (aka field 2) of interlaced field formats
     \* @standards\:  Standards the timing belongs to
     \* @flags\:      Flags
     \* @picture\_aspect\: The picture aspect ratio (hor\/vert).
     \* @cea861\_vic\: VIC code as per the CEA-861 standard.
     \* @hdmi\_vic\:   VIC code as per the HDMI standard.
     \* @reserved\:   Reserved fields, must be zeroed.
     \*
     \* A note regarding vertical interlaced timings\: height refers to the total
     \* height of the active video frame (= two fields). The blanking timings refer
     \* to the blanking of each field. So the height of the total frame is
     \* calculated as follows\:
     \*
     \* tot\_height = height + vfrontporch + vsync + vbackporch +
     \*                       il\_vfrontporch + il\_vsync + il\_vbackporch
     \*
     \* The active height of each field is height \/ 2.
     \*\/
    struct v4l2_bt_timings \{
            \_\_u32   width;
            \_\_u32   height;
            \_\_u32   interlaced;
            \_\_u32   polarities;
            \_\_u64   pixelclock;
            \_\_u32   hfrontporch;
            \_\_u32   hsync;
            \_\_u32   hbackporch;
            \_\_u32   vfrontporch;
            \_\_u32   vsync;
            \_\_u32   vbackporch;
            \_\_u32   il\_vfrontporch;
            \_\_u32   il\_vsync;
            \_\_u32   il\_vbackporch;
            \_\_u32   standards;
            \_\_u32   flags;
            struct v4l2_fract picture\_aspect;
            \_\_u8    cea861\_vic;
            \_\_u8    hdmi\_vic;
            \_\_u8    reserved[46];
    \} \_\_attribute\_\_ ((packed));

    \/\* Interlaced or progressive format \*\/
    \#define :c:type:`V4L2_DV_PROGRESSIVE <v4l2_bt_timings>`     0
    \#define :c:type:`V4L2_DV_INTERLACED <v4l2_bt_timings>`      1

    \/\* Polarities. If bit is not set, it is assumed to be negative polarity \*\/
    \#define :c:type:`V4L2_DV_VSYNC_POS_POL <v4l2_bt_timings>`   0x00000001
    \#define :c:type:`V4L2_DV_HSYNC_POS_POL <v4l2_bt_timings>`   0x00000002

    \/\* Timings standards \*\/
    \#define :ref:`V4L2_DV_BT_STD_CEA861 <dv-bt-standards>`   (1 \<\< 0)  \/\* CEA-861 Digital TV Profile \*\/
    \#define :ref:`V4L2_DV_BT_STD_DMT <dv-bt-standards>`      (1 \<\< 1)  \/\* VESA Discrete Monitor Timings \*\/
    \#define :ref:`V4L2_DV_BT_STD_CVT <dv-bt-standards>`      (1 \<\< 2)  \/\* VESA Coordinated Video Timings \*\/
    \#define :ref:`V4L2_DV_BT_STD_GTF <dv-bt-standards>`      (1 \<\< 3)  \/\* VESA Generalized Timings Formula \*\/
    \#define :ref:`V4L2_DV_BT_STD_SDI <dv-bt-standards>`      (1 \<\< 4)  \/\* SDI Timings \*\/

    \/\* Flags \*\/

    \/\*
     \* CVT\/GTF specific\: timing uses reduced blanking (CVT) or the 'Secondary
     \* GTF' curve (GTF). In both cases the horizontal and\/or vertical blanking
     \* intervals are reduced, allowing a higher resolution over the same
     \* bandwidth. This is a read-only flag.
     \*\/
    \#define :ref:`V4L2_DV_FL_REDUCED_BLANKING <dv-bt-standards>`             (1 \<\< 0)
    \/\*
     \* CEA-861 specific\: set for CEA-861 formats with a framerate of a multiple
     \* of six. These formats can be optionally played at 1 \/ 1.001 speed.
     \* This is a read-only flag.
     \*\/
    \#define :ref:`V4L2_DV_FL_CAN_REDUCE_FPS <dv-bt-standards>`               (1 \<\< 1)
    \/\*
     \* CEA-861 specific\: only valid for video transmitters, the flag is cleared
     \* by receivers.
     \* If the framerate of the format is a multiple of six, then the pixelclock
     \* used to set up the transmitter is divided by 1.001 to make it compatible
     \* with 60 Hz based standards such as NTSC and PAL-M that use a framerate of
     \* 29.97 Hz. Otherwise this flag is cleared. If the transmitter can't generate
     \* such frequencies, then the flag will also be cleared.
     \*\/
    \#define :ref:`V4L2_DV_FL_REDUCED_FPS <dv-bt-standards>`                  (1 \<\< 2)
    \/\*
     \* Specific to interlaced formats\: if set, then field 1 is really one half-line
     \* longer and field 2 is really one half-line shorter, so each field has
     \* exactly the same number of half-lines. Whether half-lines can be detected
     \* or used depends on the hardware.
     \*\/
    \#define :ref:`V4L2_DV_FL_HALF_LINE <dv-bt-standards>`                    (1 \<\< 3)
    \/\*
     \* If set, then this is a Consumer Electronics (CE) video format. Such formats
     \* differ from other formats (commonly called IT formats) in that if RGB
     \* encoding is used then by default the RGB values use limited range (i.e.
     \* use the range 16-235) as opposed to 0-255. All formats defined in CEA-861
     \* except for the 640x480 format are CE formats.
     \*\/
    \#define :ref:`V4L2_DV_FL_IS_CE_VIDEO <dv-bt-standards>`                  (1 \<\< 4)
    \/\* Some formats like SMPTE-125M have an interlaced signal with a odd
     \* total height. For these formats, if this flag is set, the first
     \* field has the extra line. If not, it is the second field.
     \*\/
    \#define :ref:`V4L2_DV_FL_FIRST_FIELD_EXTRA_LINE <dv-bt-standards>`       (1 \<\< 5)
    \/\*
     \* If set, then the picture\_aspect field is valid. Otherwise assume that the
     \* pixels are square, so the picture aspect ratio is the same as the width to
     \* height ratio.
     \*\/
    \#define :ref:`V4L2_DV_FL_HAS_PICTURE_ASPECT <dv-bt-standards>`           (1 \<\< 6)
    \/\*
     \* If set, then the cea861\_vic field is valid and contains the Video
     \* Identification Code as per the CEA-861 standard.
     \*\/
    \#define :ref:`V4L2_DV_FL_HAS_CEA861_VIC <dv-bt-standards>`               (1 \<\< 7)
    \/\*
     \* If set, then the hdmi\_vic field is valid and contains the Video
     \* Identification Code as per the HDMI standard (HDMI Vendor Specific
     \* InfoFrame).
     \*\/
    \#define :ref:`V4L2_DV_FL_HAS_HDMI_VIC <dv-bt-standards>`                 (1 \<\< 8)
    \/\*
     \* CEA-861 specific\: only valid for video receivers.
     \* If set, then HW can detect the difference between regular FPS and
     \* 1000\/1001 FPS. Note\: This flag is only valid for HDMI VIC codes with
     \* the :ref:`V4L2_DV_FL_CAN_REDUCE_FPS <dv-bt-standards>` flag set.
     \*\/
    \#define :ref:`V4L2_DV_FL_CAN_DETECT_REDUCED_FPS <dv-bt-standards>`       (1 \<\< 9)

    \/\* A few useful defines to calculate the total blanking and frame sizes \*\/
    \#define V4L2\_DV\_BT\_BLANKING\_WIDTH(bt) \\
            ((bt)-\>hfrontporch + (bt)-\>hsync + (bt)-\>hbackporch)
    \#define V4L2\_DV\_BT\_FRAME\_WIDTH(bt) \\
            ((bt)-\>width + V4L2\_DV\_BT\_BLANKING\_WIDTH(bt))
    \#define V4L2\_DV\_BT\_BLANKING\_HEIGHT(bt) \\
            ((bt)-\>vfrontporch + (bt)-\>vsync + (bt)-\>vbackporch + \\
             (bt)-\>il\_vfrontporch + (bt)-\>il\_vsync + (bt)-\>il\_vbackporch)
    \#define V4L2\_DV\_BT\_FRAME\_HEIGHT(bt) \\
            ((bt)-\>height + V4L2\_DV\_BT\_BLANKING\_HEIGHT(bt))

    \/\*\* struct v4l2_dv_timings - DV timings
     \* @type\:       the type of the timings
     \* @bt\: BT656\/1120 timings
     \*\/
    struct v4l2_dv_timings \{
            \_\_u32 type;
            union \{
                    struct v4l2_bt_timings  bt;
                    \_\_u32   reserved[32];
            \};
    \} \_\_attribute\_\_ ((packed));

    \/\* Values for the type field \*\/
    \#define :ref:`V4L2_DV_BT_656_1120 <dv-timing-types>`     0       \/\* BT.656\/1120 timing type \*\/

    \/\*\* struct v4l2_enum_dv_timings - DV timings enumeration
     \* @index\:      enumeration index
     \* @pad\:        the pad number for which to enumerate timings (used with
     \*              v4l-subdev nodes only)
     \* @reserved\:   must be zeroed
     \* @timings\:    the timings for the given index
     \*\/
    struct v4l2_enum_dv_timings \{
            \_\_u32 index;
            \_\_u32 pad;
            \_\_u32 reserved[2];
            struct v4l2_dv_timings timings;
    \};

    \/\*\* struct v4l2_bt_timings_cap - BT.656\/BT.1120 timing capabilities
     \* @min\_width\:          width in pixels
     \* @max\_width\:          width in pixels
     \* @min\_height\:         height in lines
     \* @max\_height\:         height in lines
     \* @min\_pixelclock\:     Pixel clock in HZ. Ex. 74.25MHz-\>74250000
     \* @max\_pixelclock\:     Pixel clock in HZ. Ex. 74.25MHz-\>74250000
     \* @standards\:          Supported standards
     \* @capabilities\:       Supported capabilities
     \* @reserved\:           Must be zeroed
     \*\/
    struct v4l2_bt_timings_cap \{
            \_\_u32   min\_width;
            \_\_u32   max\_width;
            \_\_u32   min\_height;
            \_\_u32   max\_height;
            \_\_u64   min\_pixelclock;
            \_\_u64   max\_pixelclock;
            \_\_u32   standards;
            \_\_u32   capabilities;
            \_\_u32   reserved[16];
    \} \_\_attribute\_\_ ((packed));

    \/\* Supports interlaced formats \*\/
    \#define :ref:`V4L2_DV_BT_CAP_INTERLACED <framebuffer-cap>`       (1 \<\< 0)
    \/\* Supports progressive formats \*\/
    \#define :ref:`V4L2_DV_BT_CAP_PROGRESSIVE <framebuffer-cap>`      (1 \<\< 1)
    \/\* Supports CVT\/GTF reduced blanking \*\/
    \#define :ref:`V4L2_DV_BT_CAP_REDUCED_BLANKING <framebuffer-cap>` (1 \<\< 2)
    \/\* Supports custom formats \*\/
    \#define :ref:`V4L2_DV_BT_CAP_CUSTOM <framebuffer-cap>`           (1 \<\< 3)

    \/\*\* struct v4l2_dv_timings_cap - DV timings capabilities
     \* @type\:       the type of the timings (same as in struct v4l2_dv_timings\ )
     \* @pad\:        the pad number for which to query capabilities (used with
     \*              v4l-subdev nodes only)
     \* @bt\:         the BT656\/1120 timings capabilities
     \*\/
    struct v4l2_dv_timings_cap \{
            \_\_u32 type;
            \_\_u32 pad;
            \_\_u32 reserved[2];
            union \{
                    struct v4l2_bt_timings_cap bt;
                    \_\_u32 raw\_data[32];
            \};
    \};

    \/\*
     \*      V I D E O   I N P U T S
     \*\/
    struct v4l2_input \{
            \_\_u32        index;             \/\*  Which input \*\/
            \_\_u8         name[32];          \/\*  Label \*\/
            \_\_u32        type;              \/\*  Type of input \*\/
            \_\_u32        audioset;          \/\*  Associated audios (bitfield) \*\/
            \_\_u32        tuner;             \/\*  enum :c:type:`v4l2_tuner_type` \*\/
            v4l2\_std\_id  std;
            \_\_u32        status;
            \_\_u32        capabilities;
            \_\_u32        reserved[3];
    \};

    \/\*  Values for the 'type' field \*\/
    \#define :ref:`V4L2_INPUT_TYPE_TUNER <input-type>`           1
    \#define :ref:`V4L2_INPUT_TYPE_CAMERA <input-type>`          2
    \#define :ref:`V4L2_INPUT_TYPE_TOUCH <input-type>`           3

    \/\* field 'status' - general \*\/
    \#define :ref:`V4L2_IN_ST_NO_POWER <input-status>`    0x00000001  \/\* Attached device is off \*\/
    \#define :ref:`V4L2_IN_ST_NO_SIGNAL <input-status>`   0x00000002
    \#define :ref:`V4L2_IN_ST_NO_COLOR <input-status>`    0x00000004

    \/\* field 'status' - sensor orientation \*\/
    \/\* If sensor is mounted upside down set both bits \*\/
    \#define :ref:`V4L2_IN_ST_HFLIP <input-status>`       0x00000010 \/\* Frames are flipped horizontally \*\/
    \#define :ref:`V4L2_IN_ST_VFLIP <input-status>`       0x00000020 \/\* Frames are flipped vertically \*\/

    \/\* field 'status' - analog \*\/
    \#define :ref:`V4L2_IN_ST_NO_H_LOCK <input-status>`   0x00000100  \/\* No horizontal sync lock \*\/
    \#define :ref:`V4L2_IN_ST_COLOR_KILL <input-status>`  0x00000200  \/\* Color killer is active \*\/
    \#define :ref:`V4L2_IN_ST_NO_V_LOCK <input-status>`   0x00000400  \/\* No vertical sync lock \*\/
    \#define :ref:`V4L2_IN_ST_NO_STD_LOCK <input-status>` 0x00000800  \/\* No standard format lock \*\/

    \/\* field 'status' - digital \*\/
    \#define :ref:`V4L2_IN_ST_NO_SYNC <input-status>`     0x00010000  \/\* No synchronization lock \*\/
    \#define :ref:`V4L2_IN_ST_NO_EQU <input-status>`      0x00020000  \/\* No equalizer lock \*\/
    \#define :ref:`V4L2_IN_ST_NO_CARRIER <input-status>`  0x00040000  \/\* Carrier recovery failed \*\/

    \/\* field 'status' - VCR and set-top box \*\/
    \#define :ref:`V4L2_IN_ST_MACROVISION <input-status>` 0x01000000  \/\* Macrovision detected \*\/
    \#define :ref:`V4L2_IN_ST_NO_ACCESS <input-status>`   0x02000000  \/\* Conditional access denied \*\/
    \#define :ref:`V4L2_IN_ST_VTR <input-status>`         0x04000000  \/\* VTR time constant \*\/

    \/\* capabilities flags \*\/
    \#define :ref:`V4L2_IN_CAP_DV_TIMINGS <input-capabilities>`          0x00000002 \/\* Supports S\_DV\_TIMINGS \*\/
    \#define V4L2\_IN\_CAP\_CUSTOM\_TIMINGS      :ref:`V4L2_IN_CAP_DV_TIMINGS <input-capabilities>` \/\* For compatibility \*\/
    \#define :ref:`V4L2_IN_CAP_STD <input-capabilities>`                 0x00000004 \/\* Supports S\_STD \*\/
    \#define :ref:`V4L2_IN_CAP_NATIVE_SIZE <input-capabilities>`         0x00000008 \/\* Supports setting native size \*\/

    \/\*
     \*      V I D E O   O U T P U T S
     \*\/
    struct v4l2_output \{
            \_\_u32        index;             \/\*  Which output \*\/
            \_\_u8         name[32];          \/\*  Label \*\/
            \_\_u32        type;              \/\*  Type of output \*\/
            \_\_u32        audioset;          \/\*  Associated audios (bitfield) \*\/
            \_\_u32        modulator;         \/\*  Associated modulator \*\/
            v4l2\_std\_id  std;
            \_\_u32        capabilities;
            \_\_u32        reserved[3];
    \};
    \/\*  Values for the 'type' field \*\/
    \#define :ref:`V4L2_OUTPUT_TYPE_MODULATOR <output-type>`              1
    \#define :ref:`V4L2_OUTPUT_TYPE_ANALOG <output-type>`                 2
    \#define :ref:`V4L2_OUTPUT_TYPE_ANALOGVGAOVERLAY <output-type>`       3

    \/\* capabilities flags \*\/
    \#define :ref:`V4L2_OUT_CAP_DV_TIMINGS <output-capabilities>`         0x00000002 \/\* Supports S\_DV\_TIMINGS \*\/
    \#define V4L2\_OUT\_CAP\_CUSTOM\_TIMINGS     :ref:`V4L2_OUT_CAP_DV_TIMINGS <output-capabilities>` \/\* For compatibility \*\/
    \#define :ref:`V4L2_OUT_CAP_STD <output-capabilities>`                0x00000004 \/\* Supports S\_STD \*\/
    \#define :ref:`V4L2_OUT_CAP_NATIVE_SIZE <output-capabilities>`        0x00000008 \/\* Supports setting native size \*\/

    \/\*
     \*      C O N T R O L S
     \*\/
    struct v4l2_control \{
            \_\_u32                id;
            \_\_s32                value;
    \};

    struct v4l2_ext_control \{
            \_\_u32 id;
            \_\_u32 size;
            \_\_u32 reserved2[1];
            union \{
                    \_\_s32 value;
                    \_\_s64 value64;
                    char \_\_user \*string;
                    \_\_u8 \_\_user \*p\_u8;
                    \_\_u16 \_\_user \*p\_u16;
                    \_\_u32 \_\_user \*p\_u32;
                    struct v4l2_area \_\_user \*p\_area;
                    void \_\_user \*ptr;
            \};
    \} \_\_attribute\_\_ ((packed));

    struct v4l2_ext_controls \{
            union \{
    \#ifndef \_\_KERNEL\_\_
                    \_\_u32 ctrl\_class;
    \#endif
                    \_\_u32 which;
            \};
            \_\_u32 count;
            \_\_u32 error\_idx;
            \_\_s32 request\_fd;
            \_\_u32 reserved[1];
            struct v4l2_ext_control \*controls;
    \};

    \#define V4L2\_CTRL\_ID\_MASK         (0x0fffffff)
    \#ifndef \_\_KERNEL\_\_
    \#define V4L2\_CTRL\_ID2CLASS(id)    ((id) \& 0x0fff0000UL)
    \#endif
    \#define V4L2\_CTRL\_ID2WHICH(id)    ((id) \& 0x0fff0000UL)
    \#define V4L2\_CTRL\_DRIVER\_PRIV(id) (((id) \& 0xffff) \>= 0x1000)
    \#define V4L2\_CTRL\_MAX\_DIMS        (4)
    \#define V4L2\_CTRL\_WHICH\_CUR\_VAL   0
    \#define V4L2\_CTRL\_WHICH\_DEF\_VAL   0x0f000000
    \#define V4L2\_CTRL\_WHICH\_REQUEST\_VAL 0x0f010000

    enum :c:type:`v4l2_ctrl_type` \{
            :c:type:`V4L2_CTRL_TYPE_INTEGER <v4l2_ctrl_type>`       = 1,
            :c:type:`V4L2_CTRL_TYPE_BOOLEAN <v4l2_ctrl_type>`       = 2,
            :c:type:`V4L2_CTRL_TYPE_MENU <v4l2_ctrl_type>`          = 3,
            :c:type:`V4L2_CTRL_TYPE_BUTTON <v4l2_ctrl_type>`        = 4,
            :c:type:`V4L2_CTRL_TYPE_INTEGER64 <v4l2_ctrl_type>`     = 5,
            :c:type:`V4L2_CTRL_TYPE_CTRL_CLASS <v4l2_ctrl_type>`    = 6,
            :c:type:`V4L2_CTRL_TYPE_STRING <v4l2_ctrl_type>`        = 7,
            :c:type:`V4L2_CTRL_TYPE_BITMASK <v4l2_ctrl_type>`       = 8,
            :c:type:`V4L2_CTRL_TYPE_INTEGER_MENU <v4l2_ctrl_type>`  = 9,

            \/\* Compound types are \>= 0x0100 \*\/
            :ref:`V4L2_CTRL_COMPOUND_TYPES <vidioc_queryctrl>`     = 0x0100,
            :c:type:`V4L2_CTRL_TYPE_U8 <v4l2_ctrl_type>`            = 0x0100,
            :c:type:`V4L2_CTRL_TYPE_U16 <v4l2_ctrl_type>`           = 0x0101,
            :c:type:`V4L2_CTRL_TYPE_U32 <v4l2_ctrl_type>`           = 0x0102,
            :c:type:`V4L2_CTRL_TYPE_AREA <v4l2_ctrl_type>`          = 0x0106,
    \};

    \/\*  Used in the \ :ref:`VIDIOC_QUERYCTRL <vidioc_queryctrl>` ioctl for querying controls \*\/
    struct v4l2_queryctrl \{
            \_\_u32                id;
            \_\_u32                type;      \/\* enum :c:type:`v4l2_ctrl_type` \*\/
            \_\_u8                 name[32];  \/\* Whatever \*\/
            \_\_s32                minimum;   \/\* Note signedness \*\/
            \_\_s32                maximum;
            \_\_s32                step;
            \_\_s32                default\_value;
            \_\_u32                flags;
            \_\_u32                reserved[2];
    \};

    \/\*  Used in the :ref:`VIDIOC_QUERY_EXT_CTRL <vidioc_queryctrl>` ioctl for querying extended controls \*\/
    struct v4l2_query_ext_ctrl \{
            \_\_u32                id;
            \_\_u32                type;
            char                 name[32];
            \_\_s64                minimum;
            \_\_s64                maximum;
            \_\_u64                step;
            \_\_s64                default\_value;
            \_\_u32                flags;
            \_\_u32                elem\_size;
            \_\_u32                elems;
            \_\_u32                nr\_of\_dims;
            \_\_u32                dims[V4L2\_CTRL\_MAX\_DIMS];
            \_\_u32                reserved[32];
    \};

    \/\*  Used in the :ref:`VIDIOC_QUERYMENU <vidioc_queryctrl>` ioctl for querying menu items \*\/
    struct v4l2_querymenu \{
            \_\_u32           id;
            \_\_u32           index;
            union \{
                    \_\_u8    name[32];       \/\* Whatever \*\/
                    \_\_s64   value;
            \};
            \_\_u32           reserved;
    \} \_\_attribute\_\_ ((packed));

    \/\*  Control flags  \*\/
    \#define :ref:`V4L2_CTRL_FLAG_DISABLED <control-flags>`         0x0001
    \#define :ref:`V4L2_CTRL_FLAG_GRABBED <control-flags>`          0x0002
    \#define :ref:`V4L2_CTRL_FLAG_READ_ONLY <control-flags>`        0x0004
    \#define :ref:`V4L2_CTRL_FLAG_UPDATE <control-flags>`           0x0008
    \#define :ref:`V4L2_CTRL_FLAG_INACTIVE <control-flags>`         0x0010
    \#define :ref:`V4L2_CTRL_FLAG_SLIDER <control-flags>`           0x0020
    \#define :ref:`V4L2_CTRL_FLAG_WRITE_ONLY <control-flags>`       0x0040
    \#define :ref:`V4L2_CTRL_FLAG_VOLATILE <control-flags>`         0x0080
    \#define :ref:`V4L2_CTRL_FLAG_HAS_PAYLOAD <control-flags>`      0x0100
    \#define :ref:`V4L2_CTRL_FLAG_EXECUTE_ON_WRITE <control-flags>` 0x0200
    \#define :ref:`V4L2_CTRL_FLAG_MODIFY_LAYOUT <control-flags>`    0x0400

    \/\*  Query flags, to be ORed with the control ID \*\/
    \#define :ref:`V4L2_CTRL_FLAG_NEXT_CTRL <control>`        0x80000000
    \#define :ref:`V4L2_CTRL_FLAG_NEXT_COMPOUND <control>`    0x40000000

    \/\*  User-class control IDs defined by V4L2 \*\/
    \#define V4L2\_CID\_MAX\_CTRLS              1024
    \/\*  IDs reserved for driver specific controls \*\/
    \#define :ref:`V4L2_CID_PRIVATE_BASE <control>`           0x08000000

    \/\*
     \*      T U N I N G
     \*\/
    struct v4l2_tuner \{
            \_\_u32                   index;
            \_\_u8                    name[32];
            \_\_u32                   type;   \/\* enum :c:type:`v4l2_tuner_type` \*\/
            \_\_u32                   capability;
            \_\_u32                   rangelow;
            \_\_u32                   rangehigh;
            \_\_u32                   rxsubchans;
            \_\_u32                   audmode;
            \_\_s32                   signal;
            \_\_s32                   afc;
            \_\_u32                   reserved[4];
    \};

    struct v4l2_modulator \{
            \_\_u32                   index;
            \_\_u8                    name[32];
            \_\_u32                   capability;
            \_\_u32                   rangelow;
            \_\_u32                   rangehigh;
            \_\_u32                   txsubchans;
            \_\_u32                   type;   \/\* enum :c:type:`v4l2_tuner_type` \*\/
            \_\_u32                   reserved[3];
    \};

    \/\*  Flags for the 'capability' field \*\/
    \#define :ref:`V4L2_TUNER_CAP_LOW <tuner-capability>`              0x0001
    \#define :ref:`V4L2_TUNER_CAP_NORM <tuner-capability>`             0x0002
    \#define :ref:`V4L2_TUNER_CAP_HWSEEK_BOUNDED <tuner-capability>`   0x0004
    \#define :ref:`V4L2_TUNER_CAP_HWSEEK_WRAP <tuner-capability>`      0x0008
    \#define :ref:`V4L2_TUNER_CAP_STEREO <tuner-capability>`           0x0010
    \#define :ref:`V4L2_TUNER_CAP_LANG2 <tuner-capability>`            0x0020
    \#define :ref:`V4L2_TUNER_CAP_SAP <tuner-capability>`              0x0020
    \#define :ref:`V4L2_TUNER_CAP_LANG1 <tuner-capability>`            0x0040
    \#define :ref:`V4L2_TUNER_CAP_RDS <tuner-capability>`              0x0080
    \#define :ref:`V4L2_TUNER_CAP_RDS_BLOCK_IO <tuner-capability>`     0x0100
    \#define :ref:`V4L2_TUNER_CAP_RDS_CONTROLS <tuner-capability>`     0x0200
    \#define :ref:`V4L2_TUNER_CAP_FREQ_BANDS <tuner-capability>`       0x0400
    \#define :ref:`V4L2_TUNER_CAP_HWSEEK_PROG_LIM <tuner-capability>`  0x0800
    \#define :ref:`V4L2_TUNER_CAP_1HZ <tuner-capability>`              0x1000

    \/\*  Flags for the 'rxsubchans' field \*\/
    \#define :ref:`V4L2_TUNER_SUB_MONO <tuner-rxsubchans>`             0x0001
    \#define :ref:`V4L2_TUNER_SUB_STEREO <tuner-rxsubchans>`           0x0002
    \#define :ref:`V4L2_TUNER_SUB_LANG2 <tuner-rxsubchans>`            0x0004
    \#define :ref:`V4L2_TUNER_SUB_SAP <tuner-rxsubchans>`              0x0004
    \#define :ref:`V4L2_TUNER_SUB_LANG1 <tuner-rxsubchans>`            0x0008
    \#define :ref:`V4L2_TUNER_SUB_RDS <tuner-rxsubchans>`              0x0010

    \/\*  Values for the 'audmode' field \*\/
    \#define :ref:`V4L2_TUNER_MODE_MONO <tuner-audmode>`            0x0000
    \#define :ref:`V4L2_TUNER_MODE_STEREO <tuner-audmode>`          0x0001
    \#define :ref:`V4L2_TUNER_MODE_LANG2 <tuner-audmode>`           0x0002
    \#define :ref:`V4L2_TUNER_MODE_SAP <tuner-audmode>`             0x0002
    \#define :ref:`V4L2_TUNER_MODE_LANG1 <tuner-audmode>`           0x0003
    \#define :ref:`V4L2_TUNER_MODE_LANG1_LANG2 <tuner-audmode>`     0x0004

    struct v4l2_frequency \{
            \_\_u32   tuner;
            \_\_u32   type;   \/\* enum :c:type:`v4l2_tuner_type` \*\/
            \_\_u32   frequency;
            \_\_u32   reserved[8];
    \};

    \#define :ref:`V4L2_BAND_MODULATION_VSB <band-modulation>`        (1 \<\< 1)
    \#define :ref:`V4L2_BAND_MODULATION_FM <band-modulation>`         (1 \<\< 2)
    \#define :ref:`V4L2_BAND_MODULATION_AM <band-modulation>`         (1 \<\< 3)

    struct v4l2_frequency_band \{
            \_\_u32   tuner;
            \_\_u32   type;   \/\* enum :c:type:`v4l2_tuner_type` \*\/
            \_\_u32   index;
            \_\_u32   capability;
            \_\_u32   rangelow;
            \_\_u32   rangehigh;
            \_\_u32   modulation;
            \_\_u32   reserved[9];
    \};

    struct v4l2_hw_freq_seek \{
            \_\_u32   tuner;
            \_\_u32   type;   \/\* enum :c:type:`v4l2_tuner_type` \*\/
            \_\_u32   seek\_upward;
            \_\_u32   wrap\_around;
            \_\_u32   spacing;
            \_\_u32   rangelow;
            \_\_u32   rangehigh;
            \_\_u32   reserved[5];
    \};

    \/\*
     \*      R D S
     \*\/

    struct v4l2_rds_data \{
            \_\_u8    lsb;
            \_\_u8    msb;
            \_\_u8    block;
    \} \_\_attribute\_\_ ((packed));

    \#define :ref:`V4L2_RDS_BLOCK_MSK <v4l2-rds-block>`       0x7
    \#define :ref:`V4L2_RDS_BLOCK_A <v4l2-rds-block>`         0
    \#define :ref:`V4L2_RDS_BLOCK_B <v4l2-rds-block>`         1
    \#define :ref:`V4L2_RDS_BLOCK_C <v4l2-rds-block>`         2
    \#define :ref:`V4L2_RDS_BLOCK_D <v4l2-rds-block>`         3
    \#define :ref:`V4L2_RDS_BLOCK_C_ALT <v4l2-rds-block>`     4
    \#define :ref:`V4L2_RDS_BLOCK_INVALID <v4l2-rds-block>`   7

    \#define :ref:`V4L2_RDS_BLOCK_CORRECTED <v4l2-rds-block>` 0x40
    \#define :ref:`V4L2_RDS_BLOCK_ERROR <v4l2-rds-block>`     0x80

    \/\*
     \*      A U D I O
     \*\/
    struct v4l2_audio \{
            \_\_u32   index;
            \_\_u8    name[32];
            \_\_u32   capability;
            \_\_u32   mode;
            \_\_u32   reserved[2];
    \};

    \/\*  Flags for the 'capability' field \*\/
    \#define :ref:`V4L2_AUDCAP_STEREO <audio-capability>`              0x00001
    \#define :ref:`V4L2_AUDCAP_AVL <audio-capability>`                 0x00002

    \/\*  Flags for the 'mode' field \*\/
    \#define :ref:`V4L2_AUDMODE_AVL <audio-mode>`                0x00001

    struct v4l2_audioout \{
            \_\_u32   index;
            \_\_u8    name[32];
            \_\_u32   capability;
            \_\_u32   mode;
            \_\_u32   reserved[2];
    \};

    \/\*
     \*      M P E G   S E R V I C E S
     \*\/
    \#if 1
    \#define :c:type:`V4L2_ENC_IDX_FRAME_I <v4l2_enc_idx>`    (0)
    \#define :c:type:`V4L2_ENC_IDX_FRAME_P <v4l2_enc_idx>`    (1)
    \#define :c:type:`V4L2_ENC_IDX_FRAME_B <v4l2_enc_idx>`    (2)
    \#define :c:type:`V4L2_ENC_IDX_FRAME_MASK <v4l2_enc_idx>` (0xf)

    struct v4l2_enc_idx_entry \{
            \_\_u64 offset;
            \_\_u64 pts;
            \_\_u32 length;
            \_\_u32 flags;
            \_\_u32 reserved[2];
    \};

    \#define :c:type:`V4L2_ENC_IDX_ENTRIES <v4l2_enc_idx>` (64)
    struct v4l2_enc_idx \{
            \_\_u32 entries;
            \_\_u32 entries\_cap;
            \_\_u32 reserved[4];
            struct v4l2_enc_idx_entry entry[V4L2\_ENC\_IDX\_ENTRIES];
    \};

    \#define :ref:`V4L2_ENC_CMD_START <encoder-cmds>`      (0)
    \#define :ref:`V4L2_ENC_CMD_STOP <encoder-cmds>`       (1)
    \#define :ref:`V4L2_ENC_CMD_PAUSE <encoder-cmds>`      (2)
    \#define :ref:`V4L2_ENC_CMD_RESUME <encoder-cmds>`     (3)

    \/\* Flags for :ref:`V4L2_ENC_CMD_STOP <encoder-cmds>` \*\/
    \#define :ref:`V4L2_ENC_CMD_STOP_AT_GOP_END <encoder-flags>`    (1 \<\< 0)

    struct v4l2_encoder_cmd \{
            \_\_u32 cmd;
            \_\_u32 flags;
            union \{
                    struct \{
                            \_\_u32 data[8];
                    \} raw;
            \};
    \};

    \/\* Decoder commands \*\/
    \#define :ref:`V4L2_DEC_CMD_START <decoder-cmds>`       (0)
    \#define :ref:`V4L2_DEC_CMD_STOP <decoder-cmds>`        (1)
    \#define :ref:`V4L2_DEC_CMD_PAUSE <decoder-cmds>`       (2)
    \#define :ref:`V4L2_DEC_CMD_RESUME <decoder-cmds>`      (3)
    \#define :ref:`V4L2_DEC_CMD_FLUSH <decoder-cmds>`       (4)

    \/\* Flags for :ref:`V4L2_DEC_CMD_START <decoder-cmds>` \*\/
    \#define :ref:`V4L2_DEC_CMD_START_MUTE_AUDIO <decoder-cmds>`   (1 \<\< 0)

    \/\* Flags for :ref:`V4L2_DEC_CMD_PAUSE <decoder-cmds>` \*\/
    \#define :ref:`V4L2_DEC_CMD_PAUSE_TO_BLACK <decoder-cmds>`     (1 \<\< 0)

    \/\* Flags for :ref:`V4L2_DEC_CMD_STOP <decoder-cmds>` \*\/
    \#define :ref:`V4L2_DEC_CMD_STOP_TO_BLACK <decoder-cmds>`      (1 \<\< 0)
    \#define :ref:`V4L2_DEC_CMD_STOP_IMMEDIATELY <decoder-cmds>`   (1 \<\< 1)

    \/\* Play format requirements (returned by the driver)\: \*\/

    \/\* The decoder has no special format requirements \*\/
    \#define :ref:`V4L2_DEC_START_FMT_NONE <decoder-cmds>`         (0)
    \/\* The decoder requires full GOPs \*\/
    \#define :ref:`V4L2_DEC_START_FMT_GOP <decoder-cmds>`          (1)

    \/\* The structure must be zeroed before use by the application
       This ensures it can be extended safely in the future. \*\/
    struct v4l2_decoder_cmd \{
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
                    \} start;

                    struct \{
                            \_\_u32 data[16];
                    \} raw;
            \};
    \};
    \#endif

    \/\*
     \*      D A T A   S E R V I C E S   ( V B I )
     \*
     \*      Data services API by Michael Schimek
     \*\/

    \/\* Raw VBI \*\/
    struct v4l2_vbi_format \{
            \_\_u32   sampling\_rate;          \/\* in 1 Hz \*\/
            \_\_u32   offset;
            \_\_u32   samples\_per\_line;
            \_\_u32   sample\_format;          \/\* V4L2\_PIX\_FMT\_\* \*\/
            \_\_s32   start[2];
            \_\_u32   count[2];
            \_\_u32   flags;                  \/\* V4L2\_VBI\_\* \*\/
            \_\_u32   reserved[2];            \/\* must be zero \*\/
    \};

    \/\*  VBI flags  \*\/
    \#define :ref:`V4L2_VBI_UNSYNC <vbifmt-flags>`         (1 \<\< 0)
    \#define :ref:`V4L2_VBI_INTERLACED <vbifmt-flags>`     (1 \<\< 1)

    \/\* ITU-R start lines for each field \*\/
    \#define :c:type:`V4L2_VBI_ITU_525_F1_START <v4l2_vbi_format>` (1)
    \#define :c:type:`V4L2_VBI_ITU_525_F2_START <v4l2_vbi_format>` (264)
    \#define :c:type:`V4L2_VBI_ITU_625_F1_START <v4l2_vbi_format>` (1)
    \#define :c:type:`V4L2_VBI_ITU_625_F2_START <v4l2_vbi_format>` (314)

    \/\* Sliced VBI
     \*
     \*    This implements is a proposal V4L2 API to allow SLICED VBI
     \* required for some hardware encoders. It should change without
     \* notice in the definitive implementation.
     \*\/

    struct v4l2_sliced_vbi_format \{
            \_\_u16   service\_set;
            \/\* service\_lines[0][...] specifies lines 0-23 (1-23 used) of the first field
               service\_lines[1][...] specifies lines 0-23 (1-23 used) of the second field
                                     (equals frame lines 313-336 for 625 line video
                                      standards, 263-286 for 525 line standards) \*\/
            \_\_u16   service\_lines[2][24];
            \_\_u32   io\_size;
            \_\_u32   reserved[2];            \/\* must be zero \*\/
    \};

    \/\* Teletext World System Teletext
       (WST), defined on ITU-R BT.653-2 \*\/
    \#define :ref:`V4L2_SLICED_TELETEXT_B <vbi-services>`          (0x0001)
    \/\* Video Program System, defined on ETS 300 231\*\/
    \#define :ref:`V4L2_SLICED_VPS <vbi-services>`                 (0x0400)
    \/\* Closed Caption, defined on EIA-608 \*\/
    \#define :ref:`V4L2_SLICED_CAPTION_525 <vbi-services>`         (0x1000)
    \/\* Wide Screen System, defined on ITU-R BT1119.1 \*\/
    \#define :ref:`V4L2_SLICED_WSS_625 <vbi-services>`             (0x4000)

    \#define :ref:`V4L2_SLICED_VBI_525 <vbi-services>`             (:ref:`V4L2_SLICED_CAPTION_525 <vbi-services>`)
    \#define :ref:`V4L2_SLICED_VBI_625 <vbi-services>`             (:ref:`V4L2_SLICED_TELETEXT_B <vbi-services>` \| :ref:`V4L2_SLICED_VPS <vbi-services>` \| :ref:`V4L2_SLICED_WSS_625 <vbi-services>`)

    struct v4l2_sliced_vbi_cap \{
            \_\_u16   service\_set;
            \/\* service\_lines[0][...] specifies lines 0-23 (1-23 used) of the first field
               service\_lines[1][...] specifies lines 0-23 (1-23 used) of the second field
                                     (equals frame lines 313-336 for 625 line video
                                      standards, 263-286 for 525 line standards) \*\/
            \_\_u16   service\_lines[2][24];
            \_\_u32   type;           \/\* enum :c:type:`v4l2_buf_type` \*\/
            \_\_u32   reserved[3];    \/\* must be 0 \*\/
    \};

    struct v4l2_sliced_vbi_data \{
            \_\_u32   id;
            \_\_u32   field;          \/\* 0\: first field, 1\: second field \*\/
            \_\_u32   line;           \/\* 1-23 \*\/
            \_\_u32   reserved;       \/\* must be 0 \*\/
            \_\_u8    data[48];
    \};

    \/\*
     \* Sliced VBI data inserted into MPEG Streams
     \*\/

    \/\*
     \* V4L2\_MPEG\_STREAM\_VBI\_FMT\_IVTV\:
     \*
     \* Structure of payload contained in an MPEG 2 Private Stream 1 PES Packet in an
     \* MPEG-2 Program Pack that contains V4L2\_MPEG\_STREAM\_VBI\_FMT\_IVTV Sliced VBI
     \* data
     \*
     \* Note, the MPEG-2 Program Pack and Private Stream 1 PES packet header
     \* definitions are not included here.  See the MPEG-2 specifications for details
     \* on these headers.
     \*\/

    \/\* Line type IDs \*\/
    \#define :ref:`V4L2_MPEG_VBI_IVTV_TELETEXT_B <ITV0-Line-Identifier-Constants>`     (1)
    \#define :ref:`V4L2_MPEG_VBI_IVTV_CAPTION_525 <ITV0-Line-Identifier-Constants>`    (4)
    \#define :ref:`V4L2_MPEG_VBI_IVTV_WSS_625 <ITV0-Line-Identifier-Constants>`        (5)
    \#define :ref:`V4L2_MPEG_VBI_IVTV_VPS <ITV0-Line-Identifier-Constants>`            (7)

    struct v4l2_mpeg_vbi_itv0_line \{
            \_\_u8 id;        \/\* One of V4L2\_MPEG\_VBI\_IVTV\_\* above \*\/
            \_\_u8 data[42];  \/\* Sliced VBI data for the line \*\/
    \} \_\_attribute\_\_ ((packed));

    struct v4l2_mpeg_vbi_itv0 \{
            \_\_le32 linemask[2]; \/\* Bitmasks of VBI service lines present \*\/
            struct v4l2_mpeg_vbi_itv0_line line[35];
    \} \_\_attribute\_\_ ((packed));

    struct v4l2_mpeg_vbi_ITV0 \{
            struct v4l2_mpeg_vbi_itv0_line line[36];
    \} \_\_attribute\_\_ ((packed));

    \#define :ref:`V4L2_MPEG_VBI_IVTV_MAGIC0 <v4l2-mpeg-vbi-fmt-ivtv-magic>`       "itv0"
    \#define :ref:`V4L2_MPEG_VBI_IVTV_MAGIC1 <v4l2-mpeg-vbi-fmt-ivtv-magic>`       "ITV0"

    struct v4l2_mpeg_vbi_fmt_ivtv \{
            \_\_u8 magic[4];
            union \{
                    struct v4l2_mpeg_vbi_itv0 itv0;
                    struct v4l2_mpeg_vbi_ITV0 ITV0;
            \};
    \} \_\_attribute\_\_ ((packed));

    \/\*
     \*      A G G R E G A T E   S T R U C T U R E S
     \*\/

    \/\*\*
     \* struct v4l2_plane_pix_format - additional, per-plane format definition
     \* @sizeimage\:          maximum size in bytes required for data, for which
     \*                      this plane will be used
     \* @bytesperline\:       distance in bytes between the leftmost pixels in two
     \*                      adjacent lines
     \*\/
    struct v4l2_plane_pix_format \{
            \_\_u32           sizeimage;
            \_\_u32           bytesperline;
            \_\_u16           reserved[6];
    \} \_\_attribute\_\_ ((packed));

    \/\*\*
     \* struct v4l2_pix_format_mplane - multiplanar format definition
     \* @width\:              image width in pixels
     \* @height\:             image height in pixels
     \* @pixelformat\:        little endian four character code (fourcc)
     \* @field\:              enum :c:type:`v4l2_field`\ ; field order (for interlaced video)
     \* @colorspace\:         enum :c:type:`v4l2_colorspace`\ ; supplemental to pixelformat
     \* @plane\_fmt\:          per-plane information
     \* @num\_planes\:         number of planes for this format
     \* @flags\:              format flags (V4L2\_PIX\_FMT\_FLAG\_\*)
     \* @ycbcr\_enc\:          enum :c:type:`v4l2_ycbcr_encoding`\ , Y'CbCr encoding
     \* @quantization\:       enum :c:type:`v4l2_quantization`\ , colorspace quantization
     \* @xfer\_func\:          enum :c:type:`v4l2_xfer_func`\ , colorspace transfer function
     \*\/
    struct v4l2_pix_format_mplane \{
            \_\_u32                           width;
            \_\_u32                           height;
            \_\_u32                           pixelformat;
            \_\_u32                           field;
            \_\_u32                           colorspace;

            struct v4l2_plane_pix_format    plane\_fmt[VIDEO\_MAX\_PLANES];
            \_\_u8                            num\_planes;
            \_\_u8                            flags;
             union \{
                    \_\_u8                            ycbcr\_enc;
                    \_\_u8                            hsv\_enc;
            \};
            \_\_u8                            quantization;
            \_\_u8                            xfer\_func;
            \_\_u8                            reserved[7];
    \} \_\_attribute\_\_ ((packed));

    \/\*\*
     \* struct v4l2_sdr_format - SDR format definition
     \* @pixelformat\:        little endian four character code (fourcc)
     \* @buffersize\:         maximum size in bytes required for data
     \*\/
    struct v4l2_sdr_format \{
            \_\_u32                           pixelformat;
            \_\_u32                           buffersize;
            \_\_u8                            reserved[24];
    \} \_\_attribute\_\_ ((packed));

    \/\*\*
     \* struct v4l2_meta_format - metadata format definition
     \* @dataformat\:         little endian four character code (fourcc)
     \* @buffersize\:         maximum size in bytes required for data
     \*\/
    struct v4l2_meta_format \{
            \_\_u32                           dataformat;
            \_\_u32                           buffersize;
    \} \_\_attribute\_\_ ((packed));

    \/\*\*
     \* struct v4l2_format - stream data format
     \* @type\:       enum :c:type:`v4l2_buf_type`\ ; type of the data stream
     \* @pix\:        definition of an image format
     \* @pix\_mp\:     definition of a multiplanar image format
     \* @win\:        definition of an overlaid image
     \* @vbi\:        raw VBI capture or output parameters
     \* @sliced\:     sliced VBI capture or output parameters
     \* @raw\_data\:   placeholder for future extensions and custom formats
     \*\/
    struct v4l2_format \{
            \_\_u32    type;
            union \{
                    struct v4l2_pix_format          pix;     \/\* :c:type:`V4L2_BUF_TYPE_VIDEO_CAPTURE <v4l2_buf_type>` \*\/
                    struct v4l2_pix_format_mplane   pix\_mp;  \/\* :c:type:`V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE <v4l2_buf_type>` \*\/
                    struct v4l2_window              win;     \/\* :c:type:`V4L2_BUF_TYPE_VIDEO_OVERLAY <v4l2_buf_type>` \*\/
                    struct v4l2_vbi_format          vbi;     \/\* :c:type:`V4L2_BUF_TYPE_VBI_CAPTURE <v4l2_buf_type>` \*\/
                    struct v4l2_sliced_vbi_format   sliced;  \/\* :c:type:`V4L2_BUF_TYPE_SLICED_VBI_CAPTURE <v4l2_buf_type>` \*\/
                    struct v4l2_sdr_format          sdr;     \/\* :c:type:`V4L2_BUF_TYPE_SDR_CAPTURE <v4l2_buf_type>` \*\/
                    struct v4l2_meta_format         meta;    \/\* :c:type:`V4L2_BUF_TYPE_META_CAPTURE <v4l2_buf_type>` \*\/
                    \_\_u8    raw\_data[200];                   \/\* user-defined \*\/
            \} fmt;
    \};

    \/\*      Stream type-dependent parameters
     \*\/
    struct v4l2_streamparm \{
            \_\_u32    type;                  \/\* enum :c:type:`v4l2_buf_type` \*\/
            union \{
                    struct v4l2_captureparm capture;
                    struct v4l2_outputparm  output;
                    \_\_u8    raw\_data[200];  \/\* user-defined \*\/
            \} parm;
    \};

    \/\*
     \*      E V E N T S
     \*\/

    \#define :ref:`V4L2_EVENT_ALL <event-type>`                          0
    \#define :ref:`V4L2_EVENT_VSYNC <event-type>`                        1
    \#define :ref:`V4L2_EVENT_EOS <event-type>`                          2
    \#define :ref:`V4L2_EVENT_CTRL <event-type>`                         3
    \#define :ref:`V4L2_EVENT_FRAME_SYNC <event-type>`                   4
    \#define :ref:`V4L2_EVENT_SOURCE_CHANGE <event-type>`                5
    \#define :ref:`V4L2_EVENT_MOTION_DET <event-type>`                   6
    \#define :ref:`V4L2_EVENT_PRIVATE_START <event-type>`                0x08000000

    \/\* Payload for :ref:`V4L2_EVENT_VSYNC <event-type>` \*\/
    struct v4l2_event_vsync \{
            \/\* Can be :c:type:`V4L2_FIELD_ANY <v4l2_field>`, \_NONE, \_TOP or \_BOTTOM \*\/
            \_\_u8 field;
    \} \_\_attribute\_\_ ((packed));

    \/\* Payload for :ref:`V4L2_EVENT_CTRL <event-type>` \*\/
    \#define :ref:`V4L2_EVENT_CTRL_CH_VALUE <ctrl-changes-flags>`                (1 \<\< 0)
    \#define :ref:`V4L2_EVENT_CTRL_CH_FLAGS <ctrl-changes-flags>`                (1 \<\< 1)
    \#define :ref:`V4L2_EVENT_CTRL_CH_RANGE <ctrl-changes-flags>`                (1 \<\< 2)

    struct v4l2_event_ctrl \{
            \_\_u32 changes;
            \_\_u32 type;
            union \{
                    \_\_s32 value;
                    \_\_s64 value64;
            \};
            \_\_u32 flags;
            \_\_s32 minimum;
            \_\_s32 maximum;
            \_\_s32 step;
            \_\_s32 default\_value;
    \};

    struct v4l2_event_frame_sync \{
            \_\_u32 frame\_sequence;
    \};

    \#define :ref:`V4L2_EVENT_SRC_CH_RESOLUTION <src-changes-flags>`            (1 \<\< 0)

    struct v4l2_event_src_change \{
            \_\_u32 changes;
    \};

    \#define :c:type:`V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ <v4l2_event_motion_det>` (1 \<\< 0)

    \/\*\*
     \* struct v4l2_event_motion_det - motion detection event
     \* @flags\:             if :c:type:`V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ <v4l2_event_motion_det>` is set, then the
     \*                     frame\_sequence field is valid.
     \* @frame\_sequence\:    the frame sequence number associated with this event.
     \* @region\_mask\:       which regions detected motion.
     \*\/
    struct v4l2_event_motion_det \{
            \_\_u32 flags;
            \_\_u32 frame\_sequence;
            \_\_u32 region\_mask;
    \};

    struct v4l2_event \{
            \_\_u32                           type;
            union \{
                    struct v4l2_event_vsync         vsync;
                    struct v4l2_event_ctrl          ctrl;
                    struct v4l2_event_frame_sync    frame\_sync;
                    struct v4l2_event_src_change    src\_change;
                    struct v4l2_event_motion_det    motion\_det;
                    \_\_u8                            data[64];
            \} u;
            \_\_u32                           pending;
            \_\_u32                           sequence;
    \#ifdef \_\_KERNEL\_\_
            struct \_\_kernel\_timespec        timestamp;
    \#else
            struct timespec                 timestamp;
    \#endif
            \_\_u32                           id;
            \_\_u32                           reserved[8];
    \};

    \#define :ref:`V4L2_EVENT_SUB_FL_SEND_INITIAL <event-flags>`          (1 \<\< 0)
    \#define :ref:`V4L2_EVENT_SUB_FL_ALLOW_FEEDBACK <event-flags>`        (1 \<\< 1)

    struct v4l2_event_subscription \{
            \_\_u32                           type;
            \_\_u32                           id;
            \_\_u32                           flags;
            \_\_u32                           reserved[5];
    \};

    \/\*
     \*      A D V A N C E D   D E B U G G I N G
     \*
     \*      NOTE\: EXPERIMENTAL API, NEVER RELY ON THIS IN APPLICATIONS!
     \*      FOR DEBUGGING, TESTING AND INTERNAL USE ONLY!
     \*\/

    \/\* \ :ref:`VIDIOC_DBG_G_REGISTER <vidioc_dbg_g_register>` and :ref:`VIDIOC_DBG_S_REGISTER <vidioc_dbg_g_register>` \*\/

    \#define :ref:`V4L2_CHIP_MATCH_BRIDGE <vidioc_dbg_g_register>`      0  \/\* Match against chip ID on the bridge (0 for the bridge) \*\/
    \#define :ref:`V4L2_CHIP_MATCH_SUBDEV <vidioc_dbg_g_register>`      4  \/\* Match against subdev index \*\/

    \/\* The following four defines are no longer in use \*\/
    \#define :ref:`V4L2_CHIP_MATCH_HOST <vidioc_dbg_g_register>` :ref:`V4L2_CHIP_MATCH_BRIDGE <vidioc_dbg_g_register>`
    \#define :ref:`V4L2_CHIP_MATCH_I2C_DRIVER <vidioc_dbg_g_register>`  1  \/\* Match against I2C driver name \*\/
    \#define :ref:`V4L2_CHIP_MATCH_I2C_ADDR <vidioc_dbg_g_register>`    2  \/\* Match against I2C 7-bit address \*\/
    \#define :ref:`V4L2_CHIP_MATCH_AC97 <vidioc_dbg_g_register>`        3  \/\* Match against ancillary AC97 chip \*\/

    struct v4l2_dbg_match \{
            \_\_u32 type; \/\* Match type \*\/
            union \{     \/\* Match this chip, meaning determined by type \*\/
                    \_\_u32 addr;
                    char name[32];
            \};
    \} \_\_attribute\_\_ ((packed));

    struct v4l2_dbg_register \{
            struct v4l2_dbg_match match;
            \_\_u32 size;     \/\* register size in bytes \*\/
            \_\_u64 reg;
            \_\_u64 val;
    \} \_\_attribute\_\_ ((packed));

    \#define :ref:`V4L2_CHIP_FL_READABLE <vidioc_dbg_g_register>` (1 \<\< 0)
    \#define :ref:`V4L2_CHIP_FL_WRITABLE <vidioc_dbg_g_register>` (1 \<\< 1)

    \/\* \ :ref:`VIDIOC_DBG_G_CHIP_INFO <vidioc_dbg_g_chip_info>` \*\/
    struct v4l2_dbg_chip_info \{
            struct v4l2_dbg_match match;
            char name[32];
            \_\_u32 flags;
            \_\_u32 reserved[32];
    \} \_\_attribute\_\_ ((packed));

    \/\*\*
     \* struct v4l2_create_buffers - \ :ref:`VIDIOC_CREATE_BUFS <vidioc_create_bufs>` argument
     \* @index\:      on return, index of the first created buffer
     \* @count\:      entry\: number of requested buffers,
     \*              return\: number of created buffers
     \* @memory\:     enum :c:type:`v4l2_memory`\ ; buffer memory type
     \* @format\:     frame format, for which buffers are requested
     \* @capabilities\: capabilities of this buffer type.
     \* @reserved\:   future extensions
     \*\/
    struct v4l2_create_buffers \{
            \_\_u32                   index;
            \_\_u32                   count;
            \_\_u32                   memory;
            struct v4l2_format      format;
            \_\_u32                   capabilities;
            \_\_u32                   reserved[7];
    \};

    \/\*
     \*      I O C T L   C O D E S   F O R   V I D E O   D E V I C E S
     \*
     \*\/
    \#define \ :ref:`VIDIOC_QUERYCAP <vidioc_querycap>`          \_IOR('V',  0, struct v4l2_capability\ )
    \#define \ :ref:`VIDIOC_ENUM_FMT <vidioc_enum_fmt>`         \_IOWR('V',  2, struct v4l2_fmtdesc\ )
    \#define \ :ref:`VIDIOC_G_FMT <vidioc_g_fmt>`            \_IOWR('V',  4, struct v4l2_format\ )
    \#define :ref:`VIDIOC_S_FMT <vidioc_g_fmt>`            \_IOWR('V',  5, struct v4l2_format\ )
    \#define \ :ref:`VIDIOC_REQBUFS <vidioc_reqbufs>`          \_IOWR('V',  8, struct v4l2_requestbuffers\ )
    \#define \ :ref:`VIDIOC_QUERYBUF <vidioc_querybuf>`         \_IOWR('V',  9, struct v4l2_buffer\ )
    \#define \ :ref:`VIDIOC_G_FBUF <vidioc_g_fbuf>`            \_IOR('V', 10, struct v4l2_framebuffer\ )
    \#define :ref:`VIDIOC_S_FBUF <vidioc_g_fbuf>`            \_IOW('V', 11, struct v4l2_framebuffer\ )
    \#define \ :ref:`VIDIOC_OVERLAY <vidioc_overlay>`           \_IOW('V', 14, int)
    \#define \ :ref:`VIDIOC_QBUF <vidioc_qbuf>`             \_IOWR('V', 15, struct v4l2_buffer\ )
    \#define \ :ref:`VIDIOC_EXPBUF <vidioc_expbuf>`           \_IOWR('V', 16, struct v4l2_exportbuffer\ )
    \#define :ref:`VIDIOC_DQBUF <vidioc_qbuf>`            \_IOWR('V', 17, struct v4l2_buffer\ )
    \#define \ :ref:`VIDIOC_STREAMON <vidioc_streamon>`          \_IOW('V', 18, int)
    \#define :ref:`VIDIOC_STREAMOFF <vidioc_streamon>`         \_IOW('V', 19, int)
    \#define \ :ref:`VIDIOC_G_PARM <vidioc_g_parm>`           \_IOWR('V', 21, struct v4l2_streamparm\ )
    \#define :ref:`VIDIOC_S_PARM <vidioc_g_parm>`           \_IOWR('V', 22, struct v4l2_streamparm\ )
    \#define \ :ref:`VIDIOC_G_STD <vidioc_g_std>`             \_IOR('V', 23, v4l2\_std\_id)
    \#define :ref:`VIDIOC_S_STD <vidioc_g_std>`             \_IOW('V', 24, v4l2\_std\_id)
    \#define \ :ref:`VIDIOC_ENUMSTD <vidioc_enumstd>`          \_IOWR('V', 25, struct v4l2_standard\ )
    \#define \ :ref:`VIDIOC_ENUMINPUT <vidioc_enuminput>`        \_IOWR('V', 26, struct v4l2_input\ )
    \#define \ :ref:`VIDIOC_G_CTRL <vidioc_g_ctrl>`           \_IOWR('V', 27, struct v4l2_control\ )
    \#define :ref:`VIDIOC_S_CTRL <vidioc_g_ctrl>`           \_IOWR('V', 28, struct v4l2_control\ )
    \#define \ :ref:`VIDIOC_G_TUNER <vidioc_g_tuner>`          \_IOWR('V', 29, struct v4l2_tuner\ )
    \#define :ref:`VIDIOC_S_TUNER <vidioc_g_tuner>`           \_IOW('V', 30, struct v4l2_tuner\ )
    \#define \ :ref:`VIDIOC_G_AUDIO <vidioc_g_audio>`           \_IOR('V', 33, struct v4l2_audio\ )
    \#define :ref:`VIDIOC_S_AUDIO <vidioc_g_audio>`           \_IOW('V', 34, struct v4l2_audio\ )
    \#define \ :ref:`VIDIOC_QUERYCTRL <vidioc_queryctrl>`        \_IOWR('V', 36, struct v4l2_queryctrl\ )
    \#define :ref:`VIDIOC_QUERYMENU <vidioc_queryctrl>`        \_IOWR('V', 37, struct v4l2_querymenu\ )
    \#define \ :ref:`VIDIOC_G_INPUT <vidioc_g_input>`           \_IOR('V', 38, int)
    \#define :ref:`VIDIOC_S_INPUT <vidioc_g_input>`          \_IOWR('V', 39, int)
    \#define \ :ref:`VIDIOC_G_EDID <vidioc_g_edid>`           \_IOWR('V', 40, struct v4l2\_edid)
    \#define :ref:`VIDIOC_S_EDID <vidioc_g_edid>`           \_IOWR('V', 41, struct v4l2\_edid)
    \#define \ :ref:`VIDIOC_G_OUTPUT <vidioc_g_output>`          \_IOR('V', 46, int)
    \#define :ref:`VIDIOC_S_OUTPUT <vidioc_g_output>`         \_IOWR('V', 47, int)
    \#define \ :ref:`VIDIOC_ENUMOUTPUT <vidioc_enumoutput>`       \_IOWR('V', 48, struct v4l2_output\ )
    \#define \ :ref:`VIDIOC_G_AUDOUT <vidioc_g_audout>`          \_IOR('V', 49, struct v4l2_audioout\ )
    \#define :ref:`VIDIOC_S_AUDOUT <vidioc_g_audout>`          \_IOW('V', 50, struct v4l2_audioout\ )
    \#define \ :ref:`VIDIOC_G_MODULATOR <vidioc_g_modulator>`      \_IOWR('V', 54, struct v4l2_modulator\ )
    \#define :ref:`VIDIOC_S_MODULATOR <vidioc_g_modulator>`       \_IOW('V', 55, struct v4l2_modulator\ )
    \#define \ :ref:`VIDIOC_G_FREQUENCY <vidioc_g_frequency>`      \_IOWR('V', 56, struct v4l2_frequency\ )
    \#define :ref:`VIDIOC_S_FREQUENCY <vidioc_g_frequency>`       \_IOW('V', 57, struct v4l2_frequency\ )
    \#define \ :ref:`VIDIOC_CROPCAP <vidioc_cropcap>`          \_IOWR('V', 58, struct v4l2_cropcap\ )
    \#define \ :ref:`VIDIOC_G_CROP <vidioc_g_crop>`           \_IOWR('V', 59, struct v4l2_crop\ )
    \#define :ref:`VIDIOC_S_CROP <vidioc_g_crop>`            \_IOW('V', 60, struct v4l2_crop\ )
    \#define \ :ref:`VIDIOC_G_JPEGCOMP <vidioc_g_jpegcomp>`        \_IOR('V', 61, struct v4l2_jpegcompression\ )
    \#define :ref:`VIDIOC_S_JPEGCOMP <vidioc_g_jpegcomp>`        \_IOW('V', 62, struct v4l2_jpegcompression\ )
    \#define \ :ref:`VIDIOC_QUERYSTD <vidioc_querystd>`          \_IOR('V', 63, v4l2\_std\_id)
    \#define :ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>`          \_IOWR('V', 64, struct v4l2_format\ )
    \#define \ :ref:`VIDIOC_ENUMAUDIO <vidioc_enumaudio>`        \_IOWR('V', 65, struct v4l2_audio\ )
    \#define \ :ref:`VIDIOC_ENUMAUDOUT <vidioc_enumaudout>`       \_IOWR('V', 66, struct v4l2_audioout\ )
    \#define \ :ref:`VIDIOC_G_PRIORITY <vidioc_g_priority>`        \_IOR('V', 67, \_\_u32) \/\* enum :c:type:`v4l2_priority` \*\/
    \#define :ref:`VIDIOC_S_PRIORITY <vidioc_g_priority>`        \_IOW('V', 68, \_\_u32) \/\* enum :c:type:`v4l2_priority` \*\/
    \#define \ :ref:`VIDIOC_G_SLICED_VBI_CAP <vidioc_g_sliced_vbi_cap>` \_IOWR('V', 69, struct v4l2_sliced_vbi_cap\ )
    \#define \ :ref:`VIDIOC_LOG_STATUS <vidioc_log_status>`         \_IO('V', 70)
    \#define \ :ref:`VIDIOC_G_EXT_CTRLS <vidioc_g_ext_ctrls>`      \_IOWR('V', 71, struct v4l2_ext_controls\ )
    \#define :ref:`VIDIOC_S_EXT_CTRLS <vidioc_g_ext_ctrls>`      \_IOWR('V', 72, struct v4l2_ext_controls\ )
    \#define :ref:`VIDIOC_TRY_EXT_CTRLS <vidioc_g_ext_ctrls>`    \_IOWR('V', 73, struct v4l2_ext_controls\ )
    \#define \ :ref:`VIDIOC_ENUM_FRAMESIZES <vidioc_enum_framesizes>`  \_IOWR('V', 74, struct v4l2_frmsizeenum\ )
    \#define \ :ref:`VIDIOC_ENUM_FRAMEINTERVALS <vidioc_enum_frameintervals>` \_IOWR('V', 75, struct v4l2_frmivalenum\ )
    \#define \ :ref:`VIDIOC_G_ENC_INDEX <vidioc_g_enc_index>`       \_IOR('V', 76, struct v4l2_enc_idx\ )
    \#define \ :ref:`VIDIOC_ENCODER_CMD <vidioc_encoder_cmd>`      \_IOWR('V', 77, struct v4l2_encoder_cmd\ )
    \#define :ref:`VIDIOC_TRY_ENCODER_CMD <vidioc_encoder_cmd>`  \_IOWR('V', 78, struct v4l2_encoder_cmd\ )

    \/\*
     \* Experimental, meant for debugging, testing and internal use.
     \* Only implemented if CONFIG\_VIDEO\_ADV\_DEBUG is defined.
     \* You must be root to use these ioctls. Never use these in applications!
     \*\/
    \#define :ref:`VIDIOC_DBG_S_REGISTER <vidioc_dbg_g_register>`    \_IOW('V', 79, struct v4l2_dbg_register\ )
    \#define \ :ref:`VIDIOC_DBG_G_REGISTER <vidioc_dbg_g_register>`   \_IOWR('V', 80, struct v4l2_dbg_register\ )

    \#define \ :ref:`VIDIOC_S_HW_FREQ_SEEK <vidioc_s_hw_freq_seek>`    \_IOW('V', 82, struct v4l2_hw_freq_seek\ )
    \#define :ref:`VIDIOC_S_DV_TIMINGS <vidioc_g_dv_timings>`     \_IOWR('V', 87, struct v4l2_dv_timings\ )
    \#define \ :ref:`VIDIOC_G_DV_TIMINGS <vidioc_g_dv_timings>`     \_IOWR('V', 88, struct v4l2_dv_timings\ )
    \#define \ :ref:`VIDIOC_DQEVENT <vidioc_dqevent>`           \_IOR('V', 89, struct v4l2_event\ )
    \#define \ :ref:`VIDIOC_SUBSCRIBE_EVENT <vidioc_subscribe_event>`   \_IOW('V', 90, struct v4l2_event_subscription\ )
    \#define \ :ref:`VIDIOC_UNSUBSCRIBE_EVENT <vidioc_unsubscribe_event>` \_IOW('V', 91, struct v4l2_event_subscription\ )
    \#define \ :ref:`VIDIOC_CREATE_BUFS <vidioc_create_bufs>`      \_IOWR('V', 92, struct v4l2_create_buffers\ )
    \#define \ :ref:`VIDIOC_PREPARE_BUF <vidioc_prepare_buf>`      \_IOWR('V', 93, struct v4l2_buffer\ )
    \#define \ :ref:`VIDIOC_G_SELECTION <vidioc_g_selection>`      \_IOWR('V', 94, struct v4l2_selection\ )
    \#define :ref:`VIDIOC_S_SELECTION <vidioc_g_selection>`      \_IOWR('V', 95, struct v4l2_selection\ )
    \#define \ :ref:`VIDIOC_DECODER_CMD <vidioc_decoder_cmd>`      \_IOWR('V', 96, struct v4l2_decoder_cmd\ )
    \#define :ref:`VIDIOC_TRY_DECODER_CMD <vidioc_decoder_cmd>`  \_IOWR('V', 97, struct v4l2_decoder_cmd\ )
    \#define \ :ref:`VIDIOC_ENUM_DV_TIMINGS <vidioc_enum_dv_timings>`  \_IOWR('V', 98, struct v4l2_enum_dv_timings\ )
    \#define \ :ref:`VIDIOC_QUERY_DV_TIMINGS <vidioc_query_dv_timings>`  \_IOR('V', 99, struct v4l2_dv_timings\ )
    \#define \ :ref:`VIDIOC_DV_TIMINGS_CAP <vidioc_dv_timings_cap>`   \_IOWR('V', 100, struct v4l2_dv_timings_cap\ )
    \#define \ :ref:`VIDIOC_ENUM_FREQ_BANDS <vidioc_enum_freq_bands>`  \_IOWR('V', 101, struct v4l2_frequency_band\ )

    \/\*
     \* Experimental, meant for debugging, testing and internal use.
     \* Never use this in applications!
     \*\/
    \#define \ :ref:`VIDIOC_DBG_G_CHIP_INFO <vidioc_dbg_g_chip_info>`  \_IOWR('V', 102, struct v4l2_dbg_chip_info\ )

    \#define :ref:`VIDIOC_QUERY_EXT_CTRL <vidioc_queryctrl>`   \_IOWR('V', 103, struct v4l2_query_ext_ctrl\ )

    \/\* Reminder\: when adding new ioctls please add support for them to
       drivers\/media\/v4l2-core\/v4l2-compat-ioctl32.c as well! \*\/

    \#define BASE\_VIDIOC\_PRIVATE     192             \/\* 192-255 are private \*\/

    \#endif \/\* \_UAPI\_\_LINUX\_VIDEODEV2\_H \*\/
