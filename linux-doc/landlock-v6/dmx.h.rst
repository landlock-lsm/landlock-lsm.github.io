.. -*- coding: utf-8; mode: rst -*-

dmx.h
=====

.. parsed-literal::

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

    enum :c:type:`dmx_output`
    \{
            \ :ref:`DMX_OUT_DECODER <dmx-out-decoder>`\ , \/\* Streaming directly to decoder. \*\/
            \ :ref:`DMX_OUT_TAP <dmx-out-tap>`\ ,     \/\* Output going to a memory buffer \*\/
                             \/\* (to be retrieved via the read command).\*\/
            \ :ref:`DMX_OUT_TS_TAP <dmx-out-ts-tap>`\ ,  \/\* Output multiplexed into a new TS  \*\/
                             \/\* (to be retrieved by reading from the \*\/
                             \/\* logical DVR device).                 \*\/
            \ :ref:`DMX_OUT_TSDEMUX_TAP <dmx-out-tsdemux-tap>` \/\* Like TS\_TAP but retrieved from the DMX device \*\/
    \};

    typedef enum :c:type:`dmx_output` \ :c:type:`dmx_output_t <dmx_output>`\ ;

    typedef :c:type:`dmx_input <dmx_input>`
    \{
            :c:type:`DMX_IN_FRONTEND <dmx_input>`, \/\* Input from a front-end device.  \*\/
            :c:type:`DMX_IN_DVR <dmx_input>`       \/\* Input from the logical DVR device.  \*\/
    \} :c:type:`dmx_input_t <dmx_input>`;

    typedef :c:type:`dmx_ts_pes <dmx_pes_type>`
    \{
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
    \} :c:type:`dmx_pes_type_t <dmx_pes_type>`;

    \#define DMX\_PES\_AUDIO    :c:type:`DMX_PES_AUDIO0 <dmx_pes_type>`
    \#define DMX\_PES\_VIDEO    :c:type:`DMX_PES_VIDEO0 <dmx_pes_type>`
    \#define DMX\_PES\_TELETEXT :c:type:`DMX_PES_TELETEXT0 <dmx_pes_type>`
    \#define DMX\_PES\_SUBTITLE :c:type:`DMX_PES_SUBTITLE0 <dmx_pes_type>`
    \#define DMX\_PES\_PCR      :c:type:`DMX_PES_PCR0 <dmx_pes_type>`

    typedef struct :c:type:`dmx_filter`
    \{
            \_\_u8  filter[DMX\_FILTER\_SIZE];
            \_\_u8  mask[DMX\_FILTER\_SIZE];
            \_\_u8  mode[DMX\_FILTER\_SIZE];
    \} :c:type:`dmx_filter_t <dmx_filter>`;

    struct :c:type:`dmx_sct_filter_params`
    \{
            \_\_u16          pid;
            :c:type:`dmx_filter_t <dmx_filter>`   filter;
            \_\_u32          timeout;
            \_\_u32          flags;
    \#define :c:type:`DMX_CHECK_CRC <dmx_sct_filter_params>`       1
    \#define :c:type:`DMX_ONESHOT <dmx_sct_filter_params>`         2
    \#define :c:type:`DMX_IMMEDIATE_START <dmx_sct_filter_params>` 4
    \#define :c:type:`DMX_KERNEL_CLIENT <dmx_sct_filter_params>`   0x8000
    \};

    struct :c:type:`dmx_pes_filter_params`
    \{
            \_\_u16          pid;
            :c:type:`dmx_input_t <dmx_input>`    input;
            \ :c:type:`dmx_output_t <dmx_output>`   output;
            :c:type:`dmx_pes_type_t <dmx_pes_type>` pes\_type;
            \_\_u32          flags;
    \};

    typedef struct :c:type:`dmx_caps` \{
            \_\_u32 caps;
            int num\_decoders;
    \} :c:type:`dmx_caps_t <dmx_caps>`;

    typedef :c:type:`dmx_source <dmx_source>` \{
            :c:type:`DMX_SOURCE_FRONT0 <dmx_source>` = 0,
            :c:type:`DMX_SOURCE_FRONT1 <dmx_source>`,
            :c:type:`DMX_SOURCE_FRONT2 <dmx_source>`,
            :c:type:`DMX_SOURCE_FRONT3 <dmx_source>`,
            :c:type:`DMX_SOURCE_DVR0 <dmx_source>`   = 16,
            :c:type:`DMX_SOURCE_DVR1 <dmx_source>`,
            :c:type:`DMX_SOURCE_DVR2 <dmx_source>`,
            :c:type:`DMX_SOURCE_DVR3 <dmx_source>`
    \} :c:type:`dmx_source_t <dmx_source>`;

    struct :c:type:`dmx_stc` \{
            unsigned int num;       \/\* input \: which STC? 0..N \*\/
            unsigned int base;      \/\* output\: divisor for stc to get 90 kHz clock \*\/
            \_\_u64 stc;              \/\* output\: stc in 'base'\*90 kHz units \*\/
    \};

    \#define \ :ref:`DMX_START <dmx_start>`                \_IO('o', 41)
    \#define \ :ref:`DMX_STOP <dmx_stop>`                 \_IO('o', 42)
    \#define \ :ref:`DMX_SET_FILTER <dmx_set_filter>`           \_IOW('o', 43, struct :c:type:`dmx_sct_filter_params`\ )
    \#define \ :ref:`DMX_SET_PES_FILTER <dmx_set_pes_filter>`       \_IOW('o', 44, struct :c:type:`dmx_pes_filter_params`\ )
    \#define \ :ref:`DMX_SET_BUFFER_SIZE <dmx_set_buffer_size>`      \_IO('o', 45)
    \#define \ :ref:`DMX_GET_PES_PIDS <dmx_get_pes_pids>`         \_IOR('o', 47, \_\_u16[5])
    \#define \ :ref:`DMX_GET_CAPS <dmx_get_caps>`             \_IOR('o', 48, :c:type:`dmx_caps_t <dmx_caps>`)
    \#define \ :ref:`DMX_SET_SOURCE <dmx_set_source>`           \_IOW('o', 49, :c:type:`dmx_source_t <dmx_source>`)
    \#define \ :ref:`DMX_GET_STC <dmx_get_stc>`              \_IOWR('o', 50, struct :c:type:`dmx_stc`\ )
    \#define \ :ref:`DMX_ADD_PID <dmx_add_pid>`              \_IOW('o', 51, \_\_u16)
    \#define \ :ref:`DMX_REMOVE_PID <dmx_remove_pid>`           \_IOW('o', 52, \_\_u16)

    \#endif \/\* \_UAPI\_DVBDMX\_H\_ \*\/
