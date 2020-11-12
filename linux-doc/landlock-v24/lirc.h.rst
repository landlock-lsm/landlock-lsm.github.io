.. -*- coding: utf-8; mode: rst -*-

lirc.h
======

.. parsed-literal::

    \/\* SPDX-License-Identifier\: GPL-2.0 WITH Linux-syscall-note \*\/
    \/\*
     \* lirc.h - linux infrared remote control header file
     \* last modified 2010\/07\/13 by Jarod Wilson
     \*\/

    \#ifndef \_LINUX\_LIRC\_H
    \#define \_LINUX\_LIRC\_H

    \#include \<linux\/types.h\>
    \#include \<linux\/ioctl.h\>

    \#define PULSE\_BIT       0x01000000
    \#define PULSE\_MASK      0x00FFFFFF

    \#define LIRC\_MODE2\_SPACE     0x00000000
    \#define LIRC\_MODE2\_PULSE     0x01000000
    \#define \ :ref:`LIRC_MODE2_FREQUENCY <lirc-mode2-frequency>` 0x02000000
    \#define \ :ref:`LIRC_MODE2_TIMEOUT <lirc-mode2-timeout>`   0x03000000

    \#define LIRC\_VALUE\_MASK      0x00FFFFFF
    \#define LIRC\_MODE2\_MASK      0xFF000000

    \#define LIRC\_SPACE(val) (((val)\&LIRC\_VALUE\_MASK) \| LIRC\_MODE2\_SPACE)
    \#define LIRC\_PULSE(val) (((val)\&LIRC\_VALUE\_MASK) \| LIRC\_MODE2\_PULSE)
    \#define LIRC\_FREQUENCY(val) (((val)\&LIRC\_VALUE\_MASK) \| \ :ref:`LIRC_MODE2_FREQUENCY <lirc-mode2-frequency>`\ )
    \#define LIRC\_TIMEOUT(val) (((val)\&LIRC\_VALUE\_MASK) \| \ :ref:`LIRC_MODE2_TIMEOUT <lirc-mode2-timeout>`\ )

    \#define LIRC\_VALUE(val) ((val)\&LIRC\_VALUE\_MASK)
    \#define LIRC\_MODE2(val) ((val)\&LIRC\_MODE2\_MASK)

    \#define LIRC\_IS\_SPACE(val) (LIRC\_MODE2(val) == LIRC\_MODE2\_SPACE)
    \#define LIRC\_IS\_PULSE(val) (LIRC\_MODE2(val) == LIRC\_MODE2\_PULSE)
    \#define LIRC\_IS\_FREQUENCY(val) (LIRC\_MODE2(val) == \ :ref:`LIRC_MODE2_FREQUENCY <lirc-mode2-frequency>`\ )
    \#define LIRC\_IS\_TIMEOUT(val) (LIRC\_MODE2(val) == \ :ref:`LIRC_MODE2_TIMEOUT <lirc-mode2-timeout>`\ )

    \/\* used heavily by lirc userspace \*\/
    \#define lirc\_t int

    \/\*\*\* lirc compatible hardware features \*\*\*\/

    \#define LIRC\_MODE2SEND(x) (x)
    \#define LIRC\_SEND2MODE(x) (x)
    \#define LIRC\_MODE2REC(x) ((x) \<\< 16)
    \#define LIRC\_REC2MODE(x) ((x) \>\> 16)

    \#define LIRC\_MODE\_RAW                  0x00000001
    \#define \ :ref:`LIRC_MODE_PULSE <lirc-mode-pulse>`                0x00000002
    \#define \ :ref:`LIRC_MODE_MODE2 <lirc-mode-mode2>`                0x00000004
    \#define \ :ref:`LIRC_MODE_SCANCODE <lirc-mode-scancode>`             0x00000008
    \#define LIRC\_MODE\_LIRCCODE             0x00000010

    \#define \ :ref:`LIRC_CAN_SEND_RAW <lirc-can-send-raw>`              LIRC\_MODE2SEND(LIRC\_MODE\_RAW)
    \#define \ :ref:`LIRC_CAN_SEND_PULSE <lirc-can-send-pulse>`            LIRC\_MODE2SEND(\ :ref:`LIRC_MODE_PULSE <lirc-mode-pulse>`\ )
    \#define \ :ref:`LIRC_CAN_SEND_MODE2 <lirc-can-send-mode2>`            LIRC\_MODE2SEND(\ :ref:`LIRC_MODE_MODE2 <lirc-mode-mode2>`\ )
    \#define \ :ref:`LIRC_CAN_SEND_LIRCCODE <lirc-can-send-lirccode>`         LIRC\_MODE2SEND(LIRC\_MODE\_LIRCCODE)

    \#define LIRC\_CAN\_SEND\_MASK             0x0000003f

    \#define \ :ref:`LIRC_CAN_SET_SEND_CARRIER <lirc-can-set-send-carrier>`      0x00000100
    \#define \ :ref:`LIRC_CAN_SET_SEND_DUTY_CYCLE <lirc-can-set-send-duty-cycle>`   0x00000200
    \#define \ :ref:`LIRC_CAN_SET_TRANSMITTER_MASK <lirc-can-set-transmitter-mask>`  0x00000400

    \#define \ :ref:`LIRC_CAN_REC_RAW <lirc-can-rec-raw>`               LIRC\_MODE2REC(LIRC\_MODE\_RAW)
    \#define \ :ref:`LIRC_CAN_REC_PULSE <lirc-can-rec-pulse>`             LIRC\_MODE2REC(\ :ref:`LIRC_MODE_PULSE <lirc-mode-pulse>`\ )
    \#define \ :ref:`LIRC_CAN_REC_MODE2 <lirc-can-rec-mode2>`             LIRC\_MODE2REC(\ :ref:`LIRC_MODE_MODE2 <lirc-mode-mode2>`\ )
    \#define \ :ref:`LIRC_CAN_REC_SCANCODE <lirc-can-rec-scancode>`          LIRC\_MODE2REC(\ :ref:`LIRC_MODE_SCANCODE <lirc-mode-scancode>`\ )
    \#define \ :ref:`LIRC_CAN_REC_LIRCCODE <lirc-can-rec-lirccode>`          LIRC\_MODE2REC(LIRC\_MODE\_LIRCCODE)

    \#define LIRC\_CAN\_REC\_MASK              LIRC\_MODE2REC(LIRC\_CAN\_SEND\_MASK)

    \#define \ :ref:`LIRC_CAN_SET_REC_CARRIER <lirc-can-set-rec-carrier>`       (\ :ref:`LIRC_CAN_SET_SEND_CARRIER <lirc-can-set-send-carrier>` \<\< 16)
    \#define LIRC\_CAN\_SET\_REC\_DUTY\_CYCLE    (\ :ref:`LIRC_CAN_SET_SEND_DUTY_CYCLE <lirc-can-set-send-duty-cycle>` \<\< 16)

    \#define \ :ref:`LIRC_CAN_SET_REC_DUTY_CYCLE_RANGE <lirc-can-set-rec-duty-cycle-range>` 0x40000000
    \#define \ :ref:`LIRC_CAN_SET_REC_CARRIER_RANGE <lirc-can-set-rec-carrier-range>`    0x80000000
    \#define \ :ref:`LIRC_CAN_GET_REC_RESOLUTION <lirc-can-get-rec-resolution>`       0x20000000
    \#define \ :ref:`LIRC_CAN_SET_REC_TIMEOUT <lirc-can-set-rec-timeout>`          0x10000000
    \#define \ :ref:`LIRC_CAN_SET_REC_FILTER <lirc-can-set-rec-filter>`           0x08000000

    \#define \ :ref:`LIRC_CAN_MEASURE_CARRIER <lirc-can-measure-carrier>`          0x02000000
    \#define \ :ref:`LIRC_CAN_USE_WIDEBAND_RECEIVER <lirc-can-use-wideband-receiver>`    0x04000000

    \#define LIRC\_CAN\_SEND(x) ((x)\&LIRC\_CAN\_SEND\_MASK)
    \#define LIRC\_CAN\_REC(x) ((x)\&LIRC\_CAN\_REC\_MASK)

    \#define \ :ref:`LIRC_CAN_NOTIFY_DECODE <lirc-can-notify-decode>`            0x01000000

    \/\*\*\* IOCTL commands for lirc driver \*\*\*\/

    \#define \ :ref:`LIRC_GET_FEATURES <lirc_get_features>`              \_IOR('i', 0x00000000, \_\_u32)

    \#define \ :ref:`LIRC_GET_SEND_MODE <lirc_get_send_mode>`             \_IOR('i', 0x00000001, \_\_u32)
    \#define \ :ref:`LIRC_GET_REC_MODE <lirc_get_rec_mode>`              \_IOR('i', 0x00000002, \_\_u32)
    \#define \ :ref:`LIRC_GET_REC_RESOLUTION <lirc_get_rec_resolution>`        \_IOR('i', 0x00000007, \_\_u32)

    \#define \ :ref:`LIRC_GET_MIN_TIMEOUT <lirc_get_min_timeout>`           \_IOR('i', 0x00000008, \_\_u32)
    \#define \ :ref:`LIRC_GET_MAX_TIMEOUT <lirc_get_max_timeout>`           \_IOR('i', 0x00000009, \_\_u32)

    \/\* code length in bits, currently only for LIRC\_MODE\_LIRCCODE \*\/
    \#define LIRC\_GET\_LENGTH                \_IOR('i', 0x0000000f, \_\_u32)

    \#define \ :ref:`LIRC_SET_SEND_MODE <lirc_set_send_mode>`             \_IOW('i', 0x00000011, \_\_u32)
    \#define \ :ref:`LIRC_SET_REC_MODE <lirc_set_rec_mode>`              \_IOW('i', 0x00000012, \_\_u32)
    \/\* Note\: these can reset the according pulse\_width \*\/
    \#define \ :ref:`LIRC_SET_SEND_CARRIER <lirc_set_send_carrier>`          \_IOW('i', 0x00000013, \_\_u32)
    \#define \ :ref:`LIRC_SET_REC_CARRIER <lirc_set_rec_carrier>`           \_IOW('i', 0x00000014, \_\_u32)
    \#define \ :ref:`LIRC_SET_SEND_DUTY_CYCLE <lirc_set_send_duty_cycle>`       \_IOW('i', 0x00000015, \_\_u32)
    \#define \ :ref:`LIRC_SET_TRANSMITTER_MASK <lirc_set_transmitter_mask>`      \_IOW('i', 0x00000017, \_\_u32)

    \/\*
     \* when a timeout != 0 is set the driver will send a
     \* \ :ref:`LIRC_MODE2_TIMEOUT <lirc-mode2-timeout>` data packet, otherwise \ :ref:`LIRC_MODE2_TIMEOUT <lirc-mode2-timeout>` is
     \* never sent, timeout is disabled by default
     \*\/
    \#define \ :ref:`LIRC_SET_REC_TIMEOUT <lirc_set_rec_timeout>`           \_IOW('i', 0x00000018, \_\_u32)

    \/\* 1 enables, 0 disables timeout reports in MODE2 \*\/
    \#define \ :ref:`LIRC_SET_REC_TIMEOUT_REPORTS <lirc_set_rec_timeout_reports>`   \_IOW('i', 0x00000019, \_\_u32)

    \/\*
     \* if enabled from the next key press on the driver will send
     \* \ :ref:`LIRC_MODE2_FREQUENCY <lirc-mode2-frequency>` packets
     \*\/
    \#define \ :ref:`LIRC_SET_MEASURE_CARRIER_MODE <lirc_set_measure_carrier_mode>`   \_IOW('i', 0x0000001d, \_\_u32)

    \/\*
     \* to set a range use \ :ref:`LIRC_SET_REC_CARRIER_RANGE <lirc_set_rec_carrier_range>` with the
     \* lower bound first and later \ :ref:`LIRC_SET_REC_CARRIER <lirc_set_rec_carrier>` with the upper bound
     \*\/
    \#define \ :ref:`LIRC_SET_REC_CARRIER_RANGE <lirc_set_rec_carrier_range>`     \_IOW('i', 0x0000001f, \_\_u32)

    \#define \ :ref:`LIRC_SET_WIDEBAND_RECEIVER <lirc_set_wideband_receiver>`     \_IOW('i', 0x00000023, \_\_u32)

    \/\*
     \* Return the recording timeout, which is either set by
     \* the ioctl \ :ref:`LIRC_SET_REC_TIMEOUT <lirc_set_rec_timeout>` or by the kernel after setting the protocols.
     \*\/
    \#define \ :ref:`LIRC_GET_REC_TIMEOUT <lirc_get_rec_timeout>`           \_IOR('i', 0x00000024, \_\_u32)

    \/\*
     \* struct lirc_scancode - decoded scancode with protocol for use with
     \*      \ :ref:`LIRC_MODE_SCANCODE <lirc-mode-scancode>`
     \*
     \* @timestamp\: Timestamp in nanoseconds using CLOCK\_MONOTONIC when IR
     \*      was decoded.
     \* @flags\: should be 0 for transmit. When receiving scancodes,
     \*      \ :ref:`LIRC_SCANCODE_FLAG_TOGGLE <lirc-scancode-flag-toggle>` or \ :ref:`LIRC_SCANCODE_FLAG_REPEAT <lirc-scancode-flag-repeat>` can be set
     \*      depending on the protocol
     \* @rc\_proto\: see enum :c:type:`rc_proto`
     \* @keycode\: the translated keycode. Set to 0 for transmit.
     \* @scancode\: the scancode received or to be sent
     \*\/
    struct lirc_scancode \{
            \_\_u64   timestamp;
            \_\_u16   flags;
            \_\_u16   rc\_proto;
            \_\_u32   keycode;
            \_\_u64   scancode;
    \};

    \/\* Set if the toggle bit of rc-5 or rc-6 is enabled \*\/
    \#define \ :ref:`LIRC_SCANCODE_FLAG_TOGGLE <lirc-scancode-flag-toggle>`       1
    \/\* Set if this is a nec or sanyo repeat \*\/
    \#define \ :ref:`LIRC_SCANCODE_FLAG_REPEAT <lirc-scancode-flag-repeat>`       2

    \/\*\*
     \* enum :c:type:`rc_proto` - the Remote Controller protocol
     \*
     \* @RC\_PROTO\_UNKNOWN\: Protocol not known
     \* @RC\_PROTO\_OTHER\: Protocol known but proprietary
     \* @RC\_PROTO\_RC5\: Philips RC5 protocol
     \* @RC\_PROTO\_RC5X\_20\: Philips RC5x 20 bit protocol
     \* @RC\_PROTO\_RC5\_SZ\: StreamZap variant of RC5
     \* @RC\_PROTO\_JVC\: JVC protocol
     \* @RC\_PROTO\_SONY12\: Sony 12 bit protocol
     \* @RC\_PROTO\_SONY15\: Sony 15 bit protocol
     \* @RC\_PROTO\_SONY20\: Sony 20 bit protocol
     \* @RC\_PROTO\_NEC\: NEC protocol
     \* @RC\_PROTO\_NECX\: Extended NEC protocol
     \* @RC\_PROTO\_NEC32\: NEC 32 bit protocol
     \* @RC\_PROTO\_SANYO\: Sanyo protocol
     \* @RC\_PROTO\_MCIR2\_KBD\: RC6-ish MCE keyboard
     \* @RC\_PROTO\_MCIR2\_MSE\: RC6-ish MCE mouse
     \* @RC\_PROTO\_RC6\_0\: Philips RC6-0-16 protocol
     \* @RC\_PROTO\_RC6\_6A\_20\: Philips RC6-6A-20 protocol
     \* @RC\_PROTO\_RC6\_6A\_24\: Philips RC6-6A-24 protocol
     \* @RC\_PROTO\_RC6\_6A\_32\: Philips RC6-6A-32 protocol
     \* @RC\_PROTO\_RC6\_MCE\: MCE (Philips RC6-6A-32 subtype) protocol
     \* @RC\_PROTO\_SHARP\: Sharp protocol
     \* @RC\_PROTO\_XMP\: XMP protocol
     \* @RC\_PROTO\_CEC\: CEC protocol
     \* @RC\_PROTO\_IMON\: iMon Pad protocol
     \* @RC\_PROTO\_RCMM12\: RC-MM protocol 12 bits
     \* @RC\_PROTO\_RCMM24\: RC-MM protocol 24 bits
     \* @RC\_PROTO\_RCMM32\: RC-MM protocol 32 bits
     \* @RC\_PROTO\_XBOX\_DVD\: Xbox DVD Movie Playback Kit protocol
     \*\/
    enum :c:type:`rc_proto` \{
            RC\_PROTO\_UNKNOWN        = 0,
            RC\_PROTO\_OTHER          = 1,
            RC\_PROTO\_RC5            = 2,
            RC\_PROTO\_RC5X\_20        = 3,
            RC\_PROTO\_RC5\_SZ         = 4,
            RC\_PROTO\_JVC            = 5,
            RC\_PROTO\_SONY12         = 6,
            RC\_PROTO\_SONY15         = 7,
            RC\_PROTO\_SONY20         = 8,
            RC\_PROTO\_NEC            = 9,
            RC\_PROTO\_NECX           = 10,
            RC\_PROTO\_NEC32          = 11,
            RC\_PROTO\_SANYO          = 12,
            RC\_PROTO\_MCIR2\_KBD      = 13,
            RC\_PROTO\_MCIR2\_MSE      = 14,
            RC\_PROTO\_RC6\_0          = 15,
            RC\_PROTO\_RC6\_6A\_20      = 16,
            RC\_PROTO\_RC6\_6A\_24      = 17,
            RC\_PROTO\_RC6\_6A\_32      = 18,
            RC\_PROTO\_RC6\_MCE        = 19,
            RC\_PROTO\_SHARP          = 20,
            RC\_PROTO\_XMP            = 21,
            RC\_PROTO\_CEC            = 22,
            RC\_PROTO\_IMON           = 23,
            RC\_PROTO\_RCMM12         = 24,
            RC\_PROTO\_RCMM24         = 25,
            RC\_PROTO\_RCMM32         = 26,
            RC\_PROTO\_XBOX\_DVD       = 27,
    \};

    \#endif
