.. -*- coding: utf-8; mode: rst -*-

dmx.h
=====

.. parsed-literal::

    \/\* SPDX-License-Identifier\: LGPL-2.1+ WITH Linux-syscall-note \*\/
    \/\*
     \* dmx.h
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

    \#ifndef \_UAPI\_DVBDMX\_H\_
    \#define \_UAPI\_DVBDMX\_H\_

    \#include \<linux\/types.h\>
    \#ifndef \_\_KERNEL\_\_
    \#include \<time.h\>
    \#endif

    \#define DMX\_FILTER\_SIZE 16

    \/\*\*
     \* enum :c:type:`dmx_output` - Output for the demux.
     \*
     \* @:c:type:`DMX_OUT_DECODER <dmx_output>`\:
     \*      Streaming directly to decoder.
     \* @:c:type:`DMX_OUT_TAP <dmx_output>`\:
     \*      Output going to a memory buffer (to be retrieved via the read command).
     \*      Delivers the stream output to the demux device on which the ioctl
     \*      is called.
     \* @:c:type:`DMX_OUT_TS_TAP <dmx_output>`\:
     \*      Output multiplexed into a new TS (to be retrieved by reading from the
     \*      logical DVR device). Routes output to the logical DVR device
     \*      \`\`\/dev\/dvb\/adapter?\/dvr?\`\`, which delivers a TS multiplexed from all
     \*      filters for which @:c:type:`DMX_OUT_TS_TAP <dmx_output>` was specified.
     \* @:c:type:`DMX_OUT_TSDEMUX_TAP <dmx_output>`\:
     \*      Like @:c:type:`DMX_OUT_TS_TAP <dmx_output>` but retrieved from the DMX device.
     \*\/
    enum :c:type:`dmx_output` \{
            :c:type:`DMX_OUT_DECODER <dmx_output>`,
            :c:type:`DMX_OUT_TAP <dmx_output>`,
            :c:type:`DMX_OUT_TS_TAP <dmx_output>`,
            :c:type:`DMX_OUT_TSDEMUX_TAP <dmx_output>`
    \};

    \/\*\*
     \* :c:type:`dmx_input <dmx_input>` - Input from the demux.
     \*
     \* @:c:type:`DMX_IN_FRONTEND <dmx_input>`\:    Input from a front-end device.
     \* @:c:type:`DMX_IN_DVR <dmx_input>`\:         Input from the logical DVR device.
     \*\/
    :c:type:`dmx_input <dmx_input>` \{
            :c:type:`DMX_IN_FRONTEND <dmx_input>`,
            :c:type:`DMX_IN_DVR <dmx_input>`
    \};

    \/\*\*
     \* :c:type:`dmx_ts_pes <dmx_pes_type>` - type of the PES filter.
     \*
     \* @:c:type:`DMX_PES_AUDIO0 <dmx_pes_type>`\:     first audio PID. Also referred as @DMX\_PES\_AUDIO.
     \* @:c:type:`DMX_PES_VIDEO0 <dmx_pes_type>`\:     first video PID. Also referred as @DMX\_PES\_VIDEO.
     \* @:c:type:`DMX_PES_TELETEXT0 <dmx_pes_type>`\:  first teletext PID. Also referred as @DMX\_PES\_TELETEXT.
     \* @:c:type:`DMX_PES_SUBTITLE0 <dmx_pes_type>`\:  first subtitle PID. Also referred as @DMX\_PES\_SUBTITLE.
     \* @:c:type:`DMX_PES_PCR0 <dmx_pes_type>`\:       first Program Clock Reference PID.
     \*                      Also referred as @DMX\_PES\_PCR.
     \*
     \* @:c:type:`DMX_PES_AUDIO1 <dmx_pes_type>`\:     second audio PID.
     \* @:c:type:`DMX_PES_VIDEO1 <dmx_pes_type>`\:     second video PID.
     \* @:c:type:`DMX_PES_TELETEXT1 <dmx_pes_type>`\:  second teletext PID.
     \* @:c:type:`DMX_PES_SUBTITLE1 <dmx_pes_type>`\:  second subtitle PID.
     \* @:c:type:`DMX_PES_PCR1 <dmx_pes_type>`\:       second Program Clock Reference PID.
     \*
     \* @:c:type:`DMX_PES_AUDIO2 <dmx_pes_type>`\:     third audio PID.
     \* @:c:type:`DMX_PES_VIDEO2 <dmx_pes_type>`\:     third video PID.
     \* @:c:type:`DMX_PES_TELETEXT2 <dmx_pes_type>`\:  third teletext PID.
     \* @:c:type:`DMX_PES_SUBTITLE2 <dmx_pes_type>`\:  third subtitle PID.
     \* @:c:type:`DMX_PES_PCR2 <dmx_pes_type>`\:       third Program Clock Reference PID.
     \*
     \* @:c:type:`DMX_PES_AUDIO3 <dmx_pes_type>`\:     fourth audio PID.
     \* @:c:type:`DMX_PES_VIDEO3 <dmx_pes_type>`\:     fourth video PID.
     \* @:c:type:`DMX_PES_TELETEXT3 <dmx_pes_type>`\:  fourth teletext PID.
     \* @:c:type:`DMX_PES_SUBTITLE3 <dmx_pes_type>`\:  fourth subtitle PID.
     \* @:c:type:`DMX_PES_PCR3 <dmx_pes_type>`\:       fourth Program Clock Reference PID.
     \*
     \* @:c:type:`DMX_PES_OTHER <dmx_pes_type>`\:      any other PID.
     \*\/

    :c:type:`dmx_ts_pes <dmx_pes_type>` \{
            :c:type:`DMX_PES_AUDIO0 <dmx_pes_type>`,
            :c:type:`DMX_PES_VIDEO0 <dmx_pes_type>`,
            :c:type:`DMX_PES_TELETEXT0 <dmx_pes_type>`,
            :c:type:`DMX_PES_SUBTITLE0 <dmx_pes_type>`,
            :c:type:`DMX_PES_PCR0 <dmx_pes_type>`,

            :c:type:`DMX_PES_AUDIO1 <dmx_pes_type>`,
            :c:type:`DMX_PES_VIDEO1 <dmx_pes_type>`,
            :c:type:`DMX_PES_TELETEXT1 <dmx_pes_type>`,
            :c:type:`DMX_PES_SUBTITLE1 <dmx_pes_type>`,
            :c:type:`DMX_PES_PCR1 <dmx_pes_type>`,

            :c:type:`DMX_PES_AUDIO2 <dmx_pes_type>`,
            :c:type:`DMX_PES_VIDEO2 <dmx_pes_type>`,
            :c:type:`DMX_PES_TELETEXT2 <dmx_pes_type>`,
            :c:type:`DMX_PES_SUBTITLE2 <dmx_pes_type>`,
            :c:type:`DMX_PES_PCR2 <dmx_pes_type>`,

            :c:type:`DMX_PES_AUDIO3 <dmx_pes_type>`,
            :c:type:`DMX_PES_VIDEO3 <dmx_pes_type>`,
            :c:type:`DMX_PES_TELETEXT3 <dmx_pes_type>`,
            :c:type:`DMX_PES_SUBTITLE3 <dmx_pes_type>`,
            :c:type:`DMX_PES_PCR3 <dmx_pes_type>`,

            :c:type:`DMX_PES_OTHER <dmx_pes_type>`
    \};

    \#define DMX\_PES\_AUDIO    :c:type:`DMX_PES_AUDIO0 <dmx_pes_type>`
    \#define DMX\_PES\_VIDEO    :c:type:`DMX_PES_VIDEO0 <dmx_pes_type>`
    \#define DMX\_PES\_TELETEXT :c:type:`DMX_PES_TELETEXT0 <dmx_pes_type>`
    \#define DMX\_PES\_SUBTITLE :c:type:`DMX_PES_SUBTITLE0 <dmx_pes_type>`
    \#define DMX\_PES\_PCR      :c:type:`DMX_PES_PCR0 <dmx_pes_type>`

    \/\*\*
     \* struct dmx_filter - Specifies a section header filter.
     \*
     \* @filter\: bit array with bits to be matched at the section header.
     \* @mask\: bits that are valid at the filter bit array.
     \* @mode\: mode of match\: if bit is zero, it will match if equal (positive
     \*        match); if bit is one, it will match if the bit is negated.
     \*
     \* Note\: All arrays in this struct have a size of DMX\_FILTER\_SIZE (16 bytes).
     \*\/
    struct dmx_filter \{
            \_\_u8  filter[DMX\_FILTER\_SIZE];
            \_\_u8  mask[DMX\_FILTER\_SIZE];
            \_\_u8  mode[DMX\_FILTER\_SIZE];
    \};

    \/\*\*
     \* struct dmx_sct_filter_params - Specifies a section filter.
     \*
     \* @pid\: PID to be filtered.
     \* @filter\: section header filter, as defined by \&struct dmx\_filter.
     \* @timeout\: maximum time to filter, in milliseconds.
     \* @flags\: extra flags for the section filter.
     \*
     \* Carries the configuration for a MPEG-TS section filter.
     \*
     \* The @flags can be\:
     \*
     \*      - \%DMX\_CHECK\_CRC - only deliver sections where the CRC check succeeded;
     \*      - \%DMX\_ONESHOT - disable the section filter after one section
     \*        has been delivered;
     \*      - \%DMX\_IMMEDIATE\_START - Start filter immediately without requiring a
     \*        \:ref\:\`DMX\_START\`.
     \*\/
    struct dmx_sct_filter_params \{
            \_\_u16             pid;
            struct dmx_filter filter;
            \_\_u32             timeout;
            \_\_u32             flags;
    \#define :c:type:`DMX_CHECK_CRC <dmx_sct_filter_params>`       1
    \#define :c:type:`DMX_ONESHOT <dmx_sct_filter_params>`         2
    \#define :c:type:`DMX_IMMEDIATE_START <dmx_sct_filter_params>` 4
    \};

    \/\*\*
     \* struct dmx_pes_filter_params - Specifies Packetized Elementary Stream (PES)
     \*      filter parameters.
     \*
     \* @pid\:        PID to be filtered.
     \* @input\:      Demux input, as specified by \&enum dmx\_input.
     \* @output\:     Demux output, as specified by \&enum dmx\_output.
     \* @pes\_type\:   Type of the pes filter, as specified by \&enum dmx\_pes\_type.
     \* @flags\:      Demux PES flags.
     \*\/
    struct dmx_pes_filter_params \{
            \_\_u16           pid;
            :c:type:`dmx_input <dmx_input>`  input;
            enum :c:type:`dmx_output` output;
            :c:type:`dmx_ts_pes <dmx_pes_type>` pes\_type;
            \_\_u32           flags;
    \};

    \/\*\*
     \* struct dmx_stc - Stores System Time Counter (STC) information.
     \*
     \* @num\: input data\: number of the STC, from 0 to N.
     \* @base\: output\: divisor for STC to get 90 kHz clock.
     \* @stc\: output\: stc in @base \* 90 kHz units.
     \*\/
    struct dmx_stc \{
            unsigned int num;
            unsigned int base;
            \_\_u64 stc;
    \};

    \/\*\*
     \* enum :c:type:`dmx_buffer_flags` - DMX memory-mapped buffer flags
     \*
     \* @:c:type:`DMX_BUFFER_FLAG_HAD_CRC32_DISCARD <dmx_buffer_flags>`\:
     \*      Indicates that the Kernel discarded one or more frames due to wrong
     \*      CRC32 checksum.
     \* @:c:type:`DMX_BUFFER_FLAG_TEI <dmx_buffer_flags>`\:
     \*      Indicates that the Kernel has detected a Transport Error indicator
     \*      (TEI) on a filtered pid.
     \* @:c:type:`DMX_BUFFER_PKT_COUNTER_MISMATCH <dmx_buffer_flags>`\:
     \*      Indicates that the Kernel has detected a packet counter mismatch
     \*      on a filtered pid.
     \* @:c:type:`DMX_BUFFER_FLAG_DISCONTINUITY_DETECTED <dmx_buffer_flags>`\:
     \*      Indicates that the Kernel has detected one or more frame discontinuity.
     \* @:c:type:`DMX_BUFFER_FLAG_DISCONTINUITY_INDICATOR <dmx_buffer_flags>`\:
     \*      Received at least one packet with a frame discontinuity indicator.
     \*\/

    enum :c:type:`dmx_buffer_flags` \{
            :c:type:`DMX_BUFFER_FLAG_HAD_CRC32_DISCARD <dmx_buffer_flags>`               = 1 \<\< 0,
            :c:type:`DMX_BUFFER_FLAG_TEI <dmx_buffer_flags>`                             = 1 \<\< 1,
            :c:type:`DMX_BUFFER_PKT_COUNTER_MISMATCH <dmx_buffer_flags>`                 = 1 \<\< 2,
            :c:type:`DMX_BUFFER_FLAG_DISCONTINUITY_DETECTED <dmx_buffer_flags>`          = 1 \<\< 3,
            :c:type:`DMX_BUFFER_FLAG_DISCONTINUITY_INDICATOR <dmx_buffer_flags>`         = 1 \<\< 4,
    \};

    \/\*\*
     \* struct dmx_buffer - dmx buffer info
     \*
     \* @index\:      id number of the buffer
     \* @bytesused\:  number of bytes occupied by data in the buffer (payload);
     \* @offset\:     for buffers with memory == DMX\_MEMORY\_MMAP;
     \*              offset from the start of the device memory for this plane,
     \*              (or a "cookie" that should be passed to mmap() as offset)
     \* @length\:     size in bytes of the buffer
     \* @flags\:      bit array of buffer flags as defined by \&enum dmx\_buffer\_flags.
     \*              Filled only at \&DMX\_DQBUF.
     \* @count\:      monotonic counter for filled buffers. Helps to identify
     \*              data stream loses. Filled only at \&DMX\_DQBUF.
     \*
     \* Contains data exchanged by application and driver using one of the streaming
     \* I\/O methods.
     \*
     \* Please notice that, for \&DMX\_QBUF, only @index should be filled.
     \* On \&DMX\_DQBUF calls, all fields will be filled by the Kernel.
     \*\/
    struct dmx_buffer \{
            \_\_u32                   index;
            \_\_u32                   bytesused;
            \_\_u32                   offset;
            \_\_u32                   length;
            \_\_u32                   flags;
            \_\_u32                   count;
    \};

    \/\*\*
     \* struct dmx_requestbuffers - request dmx buffer information
     \*
     \* @count\:      number of requested buffers,
     \* @size\:       size in bytes of the requested buffer
     \*
     \* Contains data used for requesting a dmx buffer.
     \* All reserved fields must be set to zero.
     \*\/
    struct dmx_requestbuffers \{
            \_\_u32                   count;
            \_\_u32                   size;
    \};

    \/\*\*
     \* struct dmx_exportbuffer - export of dmx buffer as DMABUF file descriptor
     \*
     \* @index\:      id number of the buffer
     \* @flags\:      flags for newly created file, currently only O\_CLOEXEC is
     \*              supported, refer to manual of open syscall for more details
     \* @fd\:         file descriptor associated with DMABUF (set by driver)
     \*
     \* Contains data used for exporting a dmx buffer as DMABUF file descriptor.
     \* The buffer is identified by a 'cookie' returned by \ :ref:`DMX_QUERYBUF <dmx_querybuf>`
     \* (identical to the cookie used to mmap() the buffer to userspace). All
     \* reserved fields must be set to zero. The field reserved0 is expected to
     \* become a structure 'type' allowing an alternative layout of the structure
     \* content. Therefore this field should not be used for any other extensions.
     \*\/
    struct dmx_exportbuffer \{
            \_\_u32           index;
            \_\_u32           flags;
            \_\_s32           fd;
    \};

    \#define \ :ref:`DMX_START <dmx_start>`                \_IO('o', 41)
    \#define \ :ref:`DMX_STOP <dmx_stop>`                 \_IO('o', 42)
    \#define \ :ref:`DMX_SET_FILTER <dmx_set_filter>`           \_IOW('o', 43, struct dmx_sct_filter_params\ )
    \#define \ :ref:`DMX_SET_PES_FILTER <dmx_set_pes_filter>`       \_IOW('o', 44, struct dmx_pes_filter_params\ )
    \#define \ :ref:`DMX_SET_BUFFER_SIZE <dmx_set_buffer_size>`      \_IO('o', 45)
    \#define \ :ref:`DMX_GET_PES_PIDS <dmx_get_pes_pids>`         \_IOR('o', 47, \_\_u16[5])
    \#define \ :ref:`DMX_GET_STC <dmx_get_stc>`              \_IOWR('o', 50, struct dmx_stc\ )
    \#define \ :ref:`DMX_ADD_PID <dmx_add_pid>`              \_IOW('o', 51, \_\_u16)
    \#define \ :ref:`DMX_REMOVE_PID <dmx_remove_pid>`           \_IOW('o', 52, \_\_u16)

    \#if !defined(\_\_KERNEL\_\_)

    \/\* This is needed for legacy userspace support \*\/
    typedef enum :c:type:`dmx_output` \ :c:type:`dmx_output_t <dmx_output>`\ ;
    typedef :c:type:`dmx_input <dmx_input>` :c:type:`dmx_input_t <dmx_input>`;
    typedef :c:type:`dmx_ts_pes <dmx_pes_type>` :c:type:`dmx_pes_type_t <dmx_pes_type>`;
    typedef struct dmx_filter :c:type:`dmx_filter_t <dmx_filter>`;

    \#endif

    \#define \ :ref:`DMX_REQBUFS <dmx_reqbufs>`              \_IOWR('o', 60, struct dmx_requestbuffers\ )
    \#define \ :ref:`DMX_QUERYBUF <dmx_querybuf>`             \_IOWR('o', 61, struct dmx_buffer\ )
    \#define \ :ref:`DMX_EXPBUF <dmx_expbuf>`               \_IOWR('o', 62, struct dmx_exportbuffer\ )
    \#define \ :ref:`DMX_QBUF <dmx_qbuf>`                 \_IOWR('o', 63, struct dmx_buffer\ )
    \#define :ref:`DMX_DQBUF <dmx_qbuf>`                \_IOWR('o', 64, struct dmx_buffer\ )

    \#endif \/\* \_DVBDMX\_H\_ \*\/
