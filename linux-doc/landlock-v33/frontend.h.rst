.. -*- coding: utf-8; mode: rst -*-

frontend.h
==========

.. parsed-literal::

    \/\* SPDX-License-Identifier\: LGPL-2.1+ WITH Linux-syscall-note \*\/
    \/\*
     \* frontend.h
     \*
     \* Copyright (C) 2000 Marcus Metzler \<marcus@convergence.de\>
     \*                  Ralph  Metzler \<ralph@convergence.de\>
     \*                  Holger Waechtler \<holger@convergence.de\>
     \*                  Andre Draszik \<ad@convergence.de\>
     \*                  for convergence integrated media GmbH
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

    \#ifndef \_DVBFRONTEND\_H\_
    \#define \_DVBFRONTEND\_H\_

    \#include \<linux\/types.h\>

    \/\*\*
     \* enum :c:type:`fe_caps` - Frontend capabilities
     \*
     \* @FE\_IS\_STUPID\:                       There's something wrong at the
     \*                                      frontend, and it can't report its
     \*                                      capabilities.
     \* @FE\_CAN\_INVERSION\_AUTO\:              Can auto-detect frequency spectral
     \*                                      band inversion
     \* @FE\_CAN\_FEC\_1\_2\:                     Supports FEC 1\/2
     \* @FE\_CAN\_FEC\_2\_3\:                     Supports FEC 2\/3
     \* @FE\_CAN\_FEC\_3\_4\:                     Supports FEC 3\/4
     \* @FE\_CAN\_FEC\_4\_5\:                     Supports FEC 4\/5
     \* @FE\_CAN\_FEC\_5\_6\:                     Supports FEC 5\/6
     \* @FE\_CAN\_FEC\_6\_7\:                     Supports FEC 6\/7
     \* @FE\_CAN\_FEC\_7\_8\:                     Supports FEC 7\/8
     \* @FE\_CAN\_FEC\_8\_9\:                     Supports FEC 8\/9
     \* @FE\_CAN\_FEC\_AUTO\:                    Can auto-detect FEC
     \* @FE\_CAN\_QPSK\:                        Supports QPSK modulation
     \* @FE\_CAN\_QAM\_16\:                      Supports 16-QAM modulation
     \* @FE\_CAN\_QAM\_32\:                      Supports 32-QAM modulation
     \* @FE\_CAN\_QAM\_64\:                      Supports 64-QAM modulation
     \* @FE\_CAN\_QAM\_128\:                     Supports 128-QAM modulation
     \* @FE\_CAN\_QAM\_256\:                     Supports 256-QAM modulation
     \* @FE\_CAN\_QAM\_AUTO\:                    Can auto-detect QAM modulation
     \* @FE\_CAN\_TRANSMISSION\_MODE\_AUTO\:      Can auto-detect transmission mode
     \* @FE\_CAN\_BANDWIDTH\_AUTO\:              Can auto-detect bandwidth
     \* @FE\_CAN\_GUARD\_INTERVAL\_AUTO\:         Can auto-detect guard interval
     \* @FE\_CAN\_HIERARCHY\_AUTO\:              Can auto-detect hierarchy
     \* @FE\_CAN\_8VSB\:                        Supports 8-VSB modulation
     \* @FE\_CAN\_16VSB\:                       Supporta 16-VSB modulation
     \* @FE\_HAS\_EXTENDED\_CAPS\:               Unused
     \* @FE\_CAN\_MULTISTREAM\:                 Supports multistream filtering
     \* @FE\_CAN\_TURBO\_FEC\:                   Supports "turbo FEC" modulation
     \* @FE\_CAN\_2G\_MODULATION\:               Supports "2nd generation" modulation,
     \*                                      e. g. DVB-S2, DVB-T2, DVB-C2
     \* @FE\_NEEDS\_BENDING\:                   Unused
     \* @FE\_CAN\_RECOVER\:                     Can recover from a cable unplug
     \*                                      automatically
     \* @FE\_CAN\_MUTE\_TS\:                     Can stop spurious TS data output
     \*\/
    enum :c:type:`fe_caps` \{
            FE\_IS\_STUPID                    = 0,
            FE\_CAN\_INVERSION\_AUTO           = 0x1,
            FE\_CAN\_FEC\_1\_2                  = 0x2,
            FE\_CAN\_FEC\_2\_3                  = 0x4,
            FE\_CAN\_FEC\_3\_4                  = 0x8,
            FE\_CAN\_FEC\_4\_5                  = 0x10,
            FE\_CAN\_FEC\_5\_6                  = 0x20,
            FE\_CAN\_FEC\_6\_7                  = 0x40,
            FE\_CAN\_FEC\_7\_8                  = 0x80,
            FE\_CAN\_FEC\_8\_9                  = 0x100,
            FE\_CAN\_FEC\_AUTO                 = 0x200,
            FE\_CAN\_QPSK                     = 0x400,
            FE\_CAN\_QAM\_16                   = 0x800,
            FE\_CAN\_QAM\_32                   = 0x1000,
            FE\_CAN\_QAM\_64                   = 0x2000,
            FE\_CAN\_QAM\_128                  = 0x4000,
            FE\_CAN\_QAM\_256                  = 0x8000,
            FE\_CAN\_QAM\_AUTO                 = 0x10000,
            FE\_CAN\_TRANSMISSION\_MODE\_AUTO   = 0x20000,
            FE\_CAN\_BANDWIDTH\_AUTO           = 0x40000,
            FE\_CAN\_GUARD\_INTERVAL\_AUTO      = 0x80000,
            FE\_CAN\_HIERARCHY\_AUTO           = 0x100000,
            FE\_CAN\_8VSB                     = 0x200000,
            FE\_CAN\_16VSB                    = 0x400000,
            FE\_HAS\_EXTENDED\_CAPS            = 0x800000,
            FE\_CAN\_MULTISTREAM              = 0x4000000,
            FE\_CAN\_TURBO\_FEC                = 0x8000000,
            FE\_CAN\_2G\_MODULATION            = 0x10000000,
            FE\_NEEDS\_BENDING                = 0x20000000,
            FE\_CAN\_RECOVER                  = 0x40000000,
            FE\_CAN\_MUTE\_TS                  = 0x80000000
    \};

    \/\*
     \* **DEPRECATED**\: Should be kept just due to backward compatibility.
     \*\/
    enum :c:type:`fe_type` \{
            \ :ref:`FE_QPSK <fe-qpsk>`\ ,
            \ :ref:`FE_QAM <fe-qam>`\ ,
            \ :ref:`FE_OFDM <fe-ofdm>`\ ,
            \ :ref:`FE_ATSC <fe-atsc>`
    \};

    \/\*\*
     \* struct dvb_frontend_info - Frontend properties and capabilities
     \*
     \* @name\:                       Name of the frontend
     \* @type\:                       \*\***DEPRECATED**\*\*.
     \*                              Should not be used on modern programs,
     \*                              as a frontend may have more than one type.
     \*                              In order to get the support types of a given
     \*                              frontend, use \:c\:type\:\`DTV\_ENUM\_DELSYS\`
     \*                              instead.
     \* @frequency\_min\:              Minimal frequency supported by the frontend.
     \* @frequency\_max\:              Minimal frequency supported by the frontend.
     \* @frequency\_stepsize\:         All frequencies are multiple of this value.
     \* @frequency\_tolerance\:        Frequency tolerance.
     \* @symbol\_rate\_min\:            Minimal symbol rate, in bauds
     \*                              (for Cable\/Satellite systems).
     \* @symbol\_rate\_max\:            Maximal symbol rate, in bauds
     \*                              (for Cable\/Satellite systems).
     \* @symbol\_rate\_tolerance\:      Maximal symbol rate tolerance, in ppm
     \*                              (for Cable\/Satellite systems).
     \* @notifier\_delay\:             \*\***DEPRECATED**\*\*. Not used by any driver.
     \* @caps\:                       Capabilities supported by the frontend,
     \*                              as specified in \&enum fe\_caps.
     \*
     \* .. note\:
     \*
     \*    \#. The frequencies are specified in Hz for Terrestrial and Cable
     \*       systems.
     \*    \#. The frequencies are specified in kHz for Satellite systems.
     \*\/
    struct dvb_frontend_info \{
            char       name[128];
            enum :c:type:`fe_type` type;      \/\* **DEPRECATED**. Use \ :ref:`DTV_ENUM_DELSYS <dtv-enum-delsys>` instead \*\/
            \_\_u32      frequency\_min;
            \_\_u32      frequency\_max;
            \_\_u32      frequency\_stepsize;
            \_\_u32      frequency\_tolerance;
            \_\_u32      symbol\_rate\_min;
            \_\_u32      symbol\_rate\_max;
            \_\_u32      symbol\_rate\_tolerance;
            \_\_u32      notifier\_delay;              \/\* **DEPRECATED** \*\/
            enum :c:type:`fe_caps` caps;
    \};

    \/\*\*
     \* struct dvb_diseqc_master_cmd - DiSEqC master command
     \*
     \* @msg\:
     \*      DiSEqC message to be sent. It contains a 3 bytes header with\:
     \*      framing + address + command, and an optional argument
     \*      of up to 3 bytes of data.
     \* @msg\_len\:
     \*      Length of the DiSEqC message. Valid values are 3 to 6.
     \*
     \* Check out the DiSEqC bus spec available on http\:\/\/www.eutelsat.org\/ for
     \* the possible messages that can be used.
     \*\/
    struct dvb_diseqc_master_cmd \{
            \_\_u8 msg[6];
            \_\_u8 msg\_len;
    \};

    \/\*\*
     \* struct dvb_diseqc_slave_reply - DiSEqC received data
     \*
     \* @msg\:
     \*      DiSEqC message buffer to store a message received via DiSEqC.
     \*      It contains one byte header with\: framing and
     \*      an optional argument of up to 3 bytes of data.
     \* @msg\_len\:
     \*      Length of the DiSEqC message. Valid values are 0 to 4,
     \*      where 0 means no message.
     \* @timeout\:
     \*      Return from ioctl after timeout ms with errorcode when
     \*      no message was received.
     \*
     \* Check out the DiSEqC bus spec available on http\:\/\/www.eutelsat.org\/ for
     \* the possible messages that can be used.
     \*\/
    struct dvb_diseqc_slave_reply \{
            \_\_u8 msg[4];
            \_\_u8 msg\_len;
            int  timeout;
    \};

    \/\*\*
     \* enum :c:type:`fe_sec_voltage` - DC Voltage used to feed the LNBf
     \*
     \* @SEC\_VOLTAGE\_13\:     Output 13V to the LNBf
     \* @SEC\_VOLTAGE\_18\:     Output 18V to the LNBf
     \* @SEC\_VOLTAGE\_OFF\:    Don't feed the LNBf with a DC voltage
     \*\/
    enum :c:type:`fe_sec_voltage` \{
            SEC\_VOLTAGE\_13,
            SEC\_VOLTAGE\_18,
            SEC\_VOLTAGE\_OFF
    \};

    \/\*\*
     \* enum :c:type:`fe_sec_tone_mode` - Type of tone to be send to the LNBf.
     \* @SEC\_TONE\_ON\:        Sends a 22kHz tone burst to the antenna.
     \* @SEC\_TONE\_OFF\:       Don't send a 22kHz tone to the antenna (except
     \*                      if the \`\`FE\_DISEQC\_\*\`\` ioctls are called).
     \*\/
    enum :c:type:`fe_sec_tone_mode` \{
            SEC\_TONE\_ON,
            SEC\_TONE\_OFF
    \};

    \/\*\*
     \* enum :c:type:`fe_sec_mini_cmd` - Type of mini burst to be sent
     \*
     \* @SEC\_MINI\_A\:         Sends a mini-DiSEqC 22kHz '0' Tone Burst to select
     \*                      satellite-A
     \* @SEC\_MINI\_B\:         Sends a mini-DiSEqC 22kHz '1' Data Burst to select
     \*                      satellite-B
     \*\/
    enum :c:type:`fe_sec_mini_cmd` \{
            SEC\_MINI\_A,
            SEC\_MINI\_B
    \};

    \/\*\*
     \* enum :c:type:`fe_status` - Enumerates the possible frontend status.
     \* @FE\_NONE\:            The frontend doesn't have any kind of lock.
     \*                      That's the initial frontend status
     \* @FE\_HAS\_SIGNAL\:      Has found something above the noise level.
     \* @FE\_HAS\_CARRIER\:     Has found a signal.
     \* @FE\_HAS\_VITERBI\:     FEC inner coding (Viterbi, LDPC or other inner code).
     \*                      is stable.
     \* @FE\_HAS\_SYNC\:        Synchronization bytes was found.
     \* @FE\_HAS\_LOCK\:        Digital TV were locked and everything is working.
     \* @FE\_TIMEDOUT\:        Fo lock within the last about 2 seconds.
     \* @FE\_REINIT\:          Frontend was reinitialized, application is recommended
     \*                      to reset DiSEqC, tone and parameters.
     \*\/
    enum :c:type:`fe_status` \{
            FE\_NONE                 = 0x00,
            FE\_HAS\_SIGNAL           = 0x01,
            FE\_HAS\_CARRIER          = 0x02,
            FE\_HAS\_VITERBI          = 0x04,
            FE\_HAS\_SYNC             = 0x08,
            FE\_HAS\_LOCK             = 0x10,
            FE\_TIMEDOUT             = 0x20,
            FE\_REINIT               = 0x40,
    \};

    \/\*\*
     \* enum :c:type:`fe_spectral_inversion` - Type of inversion band
     \*
     \* @INVERSION\_OFF\:      Don't do spectral band inversion.
     \* @INVERSION\_ON\:       Do spectral band inversion.
     \* @INVERSION\_AUTO\:     Autodetect spectral band inversion.
     \*
     \* This parameter indicates if spectral inversion should be presumed or
     \* not. In the automatic setting (\`\`INVERSION\_AUTO\`\`) the hardware will try
     \* to figure out the correct setting by itself. If the hardware doesn't
     \* support, the \%dvb\_frontend will try to lock at the carrier first with
     \* inversion off. If it fails, it will try to enable inversion.
     \*\/
    enum :c:type:`fe_spectral_inversion` \{
            INVERSION\_OFF,
            INVERSION\_ON,
            INVERSION\_AUTO
    \};

    \/\*\*
     \* enum :c:type:`fe_code_rate` - Type of Forward Error Correction (FEC)
     \*
     \*
     \* @FEC\_NONE\: No Forward Error Correction Code
     \* @FEC\_1\_2\:  Forward Error Correction Code 1\/2
     \* @FEC\_2\_3\:  Forward Error Correction Code 2\/3
     \* @FEC\_3\_4\:  Forward Error Correction Code 3\/4
     \* @FEC\_4\_5\:  Forward Error Correction Code 4\/5
     \* @FEC\_5\_6\:  Forward Error Correction Code 5\/6
     \* @FEC\_6\_7\:  Forward Error Correction Code 6\/7
     \* @FEC\_7\_8\:  Forward Error Correction Code 7\/8
     \* @FEC\_8\_9\:  Forward Error Correction Code 8\/9
     \* @FEC\_AUTO\: Autodetect Error Correction Code
     \* @FEC\_3\_5\:  Forward Error Correction Code 3\/5
     \* @FEC\_9\_10\: Forward Error Correction Code 9\/10
     \* @FEC\_2\_5\:  Forward Error Correction Code 2\/5
     \*
     \* Please note that not all FEC types are supported by a given standard.
     \*\/
    enum :c:type:`fe_code_rate` \{
            FEC\_NONE = 0,
            FEC\_1\_2,
            FEC\_2\_3,
            FEC\_3\_4,
            FEC\_4\_5,
            FEC\_5\_6,
            FEC\_6\_7,
            FEC\_7\_8,
            FEC\_8\_9,
            FEC\_AUTO,
            FEC\_3\_5,
            FEC\_9\_10,
            FEC\_2\_5,
    \};

    \/\*\*
     \* enum :c:type:`fe_modulation` - Type of modulation\/constellation
     \* @QPSK\:       QPSK modulation
     \* @QAM\_16\:     16-QAM modulation
     \* @QAM\_32\:     32-QAM modulation
     \* @QAM\_64\:     64-QAM modulation
     \* @QAM\_128\:    128-QAM modulation
     \* @QAM\_256\:    256-QAM modulation
     \* @QAM\_AUTO\:   Autodetect QAM modulation
     \* @VSB\_8\:      8-VSB modulation
     \* @VSB\_16\:     16-VSB modulation
     \* @PSK\_8\:      8-PSK modulation
     \* @APSK\_16\:    16-APSK modulation
     \* @APSK\_32\:    32-APSK modulation
     \* @DQPSK\:      DQPSK modulation
     \* @QAM\_4\_NR\:   4-QAM-NR modulation
     \*
     \* Please note that not all modulations are supported by a given standard.
     \*
     \*\/
    enum :c:type:`fe_modulation` \{
            QPSK,
            QAM\_16,
            QAM\_32,
            QAM\_64,
            QAM\_128,
            QAM\_256,
            QAM\_AUTO,
            VSB\_8,
            VSB\_16,
            PSK\_8,
            APSK\_16,
            APSK\_32,
            DQPSK,
            QAM\_4\_NR,
    \};

    \/\*\*
     \* enum :c:type:`fe_transmit_mode` - Transmission mode
     \*
     \* @TRANSMISSION\_MODE\_AUTO\:
     \*      Autodetect transmission mode. The hardware will try to find the
     \*      correct FFT-size (if capable) to fill in the missing parameters.
     \* @TRANSMISSION\_MODE\_1K\:
     \*      Transmission mode 1K
     \* @TRANSMISSION\_MODE\_2K\:
     \*      Transmission mode 2K
     \* @TRANSMISSION\_MODE\_8K\:
     \*      Transmission mode 8K
     \* @TRANSMISSION\_MODE\_4K\:
     \*      Transmission mode 4K
     \* @TRANSMISSION\_MODE\_16K\:
     \*      Transmission mode 16K
     \* @TRANSMISSION\_MODE\_32K\:
     \*      Transmission mode 32K
     \* @TRANSMISSION\_MODE\_C1\:
     \*      Single Carrier (C=1) transmission mode (DTMB only)
     \* @TRANSMISSION\_MODE\_C3780\:
     \*      Multi Carrier (C=3780) transmission mode (DTMB only)
     \*
     \* Please note that not all transmission modes are supported by a given
     \* standard.
     \*\/
    enum :c:type:`fe_transmit_mode` \{
            TRANSMISSION\_MODE\_2K,
            TRANSMISSION\_MODE\_8K,
            TRANSMISSION\_MODE\_AUTO,
            TRANSMISSION\_MODE\_4K,
            TRANSMISSION\_MODE\_1K,
            TRANSMISSION\_MODE\_16K,
            TRANSMISSION\_MODE\_32K,
            TRANSMISSION\_MODE\_C1,
            TRANSMISSION\_MODE\_C3780,
    \};

    \/\*\*
     \* enum :c:type:`fe_guard_interval` - Guard interval
     \*
     \* @GUARD\_INTERVAL\_AUTO\:        Autodetect the guard interval
     \* @GUARD\_INTERVAL\_1\_128\:       Guard interval 1\/128
     \* @GUARD\_INTERVAL\_1\_32\:        Guard interval 1\/32
     \* @GUARD\_INTERVAL\_1\_16\:        Guard interval 1\/16
     \* @GUARD\_INTERVAL\_1\_8\:         Guard interval 1\/8
     \* @GUARD\_INTERVAL\_1\_4\:         Guard interval 1\/4
     \* @GUARD\_INTERVAL\_19\_128\:      Guard interval 19\/128
     \* @GUARD\_INTERVAL\_19\_256\:      Guard interval 19\/256
     \* @GUARD\_INTERVAL\_PN420\:       PN length 420 (1\/4)
     \* @GUARD\_INTERVAL\_PN595\:       PN length 595 (1\/6)
     \* @GUARD\_INTERVAL\_PN945\:       PN length 945 (1\/9)
     \*
     \* Please note that not all guard intervals are supported by a given standard.
     \*\/
    enum :c:type:`fe_guard_interval` \{
            GUARD\_INTERVAL\_1\_32,
            GUARD\_INTERVAL\_1\_16,
            GUARD\_INTERVAL\_1\_8,
            GUARD\_INTERVAL\_1\_4,
            GUARD\_INTERVAL\_AUTO,
            GUARD\_INTERVAL\_1\_128,
            GUARD\_INTERVAL\_19\_128,
            GUARD\_INTERVAL\_19\_256,
            GUARD\_INTERVAL\_PN420,
            GUARD\_INTERVAL\_PN595,
            GUARD\_INTERVAL\_PN945,
    \};

    \/\*\*
     \* enum :c:type:`fe_hierarchy` - Hierarchy
     \* @HIERARCHY\_NONE\:     No hierarchy
     \* @HIERARCHY\_AUTO\:     Autodetect hierarchy (if supported)
     \* @HIERARCHY\_1\:        Hierarchy 1
     \* @HIERARCHY\_2\:        Hierarchy 2
     \* @HIERARCHY\_4\:        Hierarchy 4
     \*
     \* Please note that not all hierarchy types are supported by a given standard.
     \*\/
    enum :c:type:`fe_hierarchy` \{
            HIERARCHY\_NONE,
            HIERARCHY\_1,
            HIERARCHY\_2,
            HIERARCHY\_4,
            HIERARCHY\_AUTO
    \};

    \/\*\*
     \* enum :c:type:`fe_interleaving` - Interleaving
     \* @INTERLEAVING\_NONE\:  No interleaving.
     \* @INTERLEAVING\_AUTO\:  Auto-detect interleaving.
     \* @INTERLEAVING\_240\:   Interleaving of 240 symbols.
     \* @INTERLEAVING\_720\:   Interleaving of 720 symbols.
     \*
     \* Please note that, currently, only DTMB uses it.
     \*\/
    enum :c:type:`fe_interleaving` \{
            INTERLEAVING\_NONE,
            INTERLEAVING\_AUTO,
            INTERLEAVING\_240,
            INTERLEAVING\_720,
    \};

    \/\* DVBv5 property Commands \*\/

    \#define \ :ref:`DTV_UNDEFINED <dtv-undefined>`           0
    \#define \ :ref:`DTV_TUNE <dtv-tune>`                1
    \#define \ :ref:`DTV_CLEAR <dtv-clear>`               2
    \#define \ :ref:`DTV_FREQUENCY <dtv-frequency>`           3
    \#define \ :ref:`DTV_MODULATION <dtv-modulation>`          4
    \#define \ :ref:`DTV_BANDWIDTH_HZ <dtv-bandwidth-hz>`        5
    \#define \ :ref:`DTV_INVERSION <dtv-inversion>`           6
    \#define \ :ref:`DTV_DISEQC_MASTER <dtv-diseqc-master>`       7
    \#define \ :ref:`DTV_SYMBOL_RATE <dtv-symbol-rate>`         8
    \#define \ :ref:`DTV_INNER_FEC <dtv-inner-fec>`           9
    \#define \ :ref:`DTV_VOLTAGE <dtv-voltage>`             10
    \#define \ :ref:`DTV_TONE <dtv-tone>`                11
    \#define \ :ref:`DTV_PILOT <dtv-pilot>`               12
    \#define \ :ref:`DTV_ROLLOFF <dtv-rolloff>`             13
    \#define \ :ref:`DTV_DISEQC_SLAVE_REPLY <dtv-diseqc-slave-reply>`  14

    \/\* Basic enumeration set for querying unlimited capabilities \*\/
    \#define \ :ref:`DTV_FE_CAPABILITY_COUNT <dtv-fe-capability-count>` 15
    \#define \ :ref:`DTV_FE_CAPABILITY <dtv-fe-capability>`       16
    \#define \ :ref:`DTV_DELIVERY_SYSTEM <dtv-delivery-system>`     17

    \/\* ISDB-T and ISDB-Tsb \*\/
    \#define \ :ref:`DTV_ISDBT_PARTIAL_RECEPTION <dtv-isdbt-partial-reception>`     18
    \#define \ :ref:`DTV_ISDBT_SOUND_BROADCASTING <dtv-isdbt-sound-broadcasting>`    19

    \#define \ :ref:`DTV_ISDBT_SB_SUBCHANNEL_ID <dtv-isdbt-sb-subchannel-id>`      20
    \#define \ :ref:`DTV_ISDBT_SB_SEGMENT_IDX <dtv-isdbt-sb-segment-idx>`        21
    \#define \ :ref:`DTV_ISDBT_SB_SEGMENT_COUNT <dtv-isdbt-sb-segment-count>`      22

    \#define :ref:`DTV_ISDBT_LAYERA_FEC <dtv-isdbt-layer-fec>`                    23
    \#define :ref:`DTV_ISDBT_LAYERA_MODULATION <dtv-isdbt-layer-modulation>`             24
    \#define :ref:`DTV_ISDBT_LAYERA_SEGMENT_COUNT <dtv-isdbt-layer-segment-count>`          25
    \#define :ref:`DTV_ISDBT_LAYERA_TIME_INTERLEAVING <dtv-isdbt-layer-time-interleaving>`      26

    \#define :ref:`DTV_ISDBT_LAYERB_FEC <dtv-isdbt-layer-fec>`                    27
    \#define :ref:`DTV_ISDBT_LAYERB_MODULATION <dtv-isdbt-layer-modulation>`             28
    \#define :ref:`DTV_ISDBT_LAYERB_SEGMENT_COUNT <dtv-isdbt-layer-segment-count>`          29
    \#define :ref:`DTV_ISDBT_LAYERB_TIME_INTERLEAVING <dtv-isdbt-layer-time-interleaving>`      30

    \#define :ref:`DTV_ISDBT_LAYERC_FEC <dtv-isdbt-layer-fec>`                    31
    \#define :ref:`DTV_ISDBT_LAYERC_MODULATION <dtv-isdbt-layer-modulation>`             32
    \#define :ref:`DTV_ISDBT_LAYERC_SEGMENT_COUNT <dtv-isdbt-layer-segment-count>`          33
    \#define :ref:`DTV_ISDBT_LAYERC_TIME_INTERLEAVING <dtv-isdbt-layer-time-interleaving>`      34

    \#define \ :ref:`DTV_API_VERSION <dtv-api-version>`         35

    \#define \ :ref:`DTV_CODE_RATE_HP <dtv-code-rate-hp>`        36
    \#define \ :ref:`DTV_CODE_RATE_LP <dtv-code-rate-lp>`        37
    \#define \ :ref:`DTV_GUARD_INTERVAL <dtv-guard-interval>`      38
    \#define \ :ref:`DTV_TRANSMISSION_MODE <dtv-transmission-mode>`   39
    \#define \ :ref:`DTV_HIERARCHY <dtv-hierarchy>`           40

    \#define \ :ref:`DTV_ISDBT_LAYER_ENABLED <dtv-isdbt-layer-enabled>` 41

    \#define \ :ref:`DTV_STREAM_ID <dtv-stream-id>`           42
    \#define DTV\_ISDBS\_TS\_ID\_LEGACY  \ :ref:`DTV_STREAM_ID <dtv-stream-id>`
    \#define \ :ref:`DTV_DVBT2_PLP_ID_LEGACY <dtv-dvbt2-plp-id-legacy>` 43

    \#define \ :ref:`DTV_ENUM_DELSYS <dtv-enum-delsys>`         44

    \/\* ATSC-MH \*\/
    \#define \ :ref:`DTV_ATSCMH_FIC_VER <dtv-atscmh-fic-ver>`              45
    \#define \ :ref:`DTV_ATSCMH_PARADE_ID <dtv-atscmh-parade-id>`            46
    \#define \ :ref:`DTV_ATSCMH_NOG <dtv-atscmh-nog>`                  47
    \#define \ :ref:`DTV_ATSCMH_TNOG <dtv-atscmh-tnog>`                 48
    \#define \ :ref:`DTV_ATSCMH_SGN <dtv-atscmh-sgn>`                  49
    \#define \ :ref:`DTV_ATSCMH_PRC <dtv-atscmh-prc>`                  50
    \#define \ :ref:`DTV_ATSCMH_RS_FRAME_MODE <dtv-atscmh-rs-frame-mode>`        51
    \#define \ :ref:`DTV_ATSCMH_RS_FRAME_ENSEMBLE <dtv-atscmh-rs-frame-ensemble>`    52
    \#define \ :ref:`DTV_ATSCMH_RS_CODE_MODE_PRI <dtv-atscmh-rs-code-mode-pri>`     53
    \#define \ :ref:`DTV_ATSCMH_RS_CODE_MODE_SEC <dtv-atscmh-rs-code-mode-sec>`     54
    \#define \ :ref:`DTV_ATSCMH_SCCC_BLOCK_MODE <dtv-atscmh-sccc-block-mode>`      55
    \#define \ :ref:`DTV_ATSCMH_SCCC_CODE_MODE_A <dtv-atscmh-sccc-code-mode-a>`     56
    \#define \ :ref:`DTV_ATSCMH_SCCC_CODE_MODE_B <dtv-atscmh-sccc-code-mode-b>`     57
    \#define \ :ref:`DTV_ATSCMH_SCCC_CODE_MODE_C <dtv-atscmh-sccc-code-mode-c>`     58
    \#define \ :ref:`DTV_ATSCMH_SCCC_CODE_MODE_D <dtv-atscmh-sccc-code-mode-d>`     59

    \#define \ :ref:`DTV_INTERLEAVING <dtv-interleaving>`                        60
    \#define \ :ref:`DTV_LNA <dtv-lna>`                                 61

    \/\* Quality parameters \*\/
    \#define \ :ref:`DTV_STAT_SIGNAL_STRENGTH <dtv-stat-signal-strength>`        62
    \#define \ :ref:`DTV_STAT_CNR <dtv-stat-cnr>`                    63
    \#define \ :ref:`DTV_STAT_PRE_ERROR_BIT_COUNT <dtv-stat-pre-error-bit-count>`    64
    \#define \ :ref:`DTV_STAT_PRE_TOTAL_BIT_COUNT <dtv-stat-pre-total-bit-count>`    65
    \#define \ :ref:`DTV_STAT_POST_ERROR_BIT_COUNT <dtv-stat-post-error-bit-count>`   66
    \#define \ :ref:`DTV_STAT_POST_TOTAL_BIT_COUNT <dtv-stat-post-total-bit-count>`   67
    \#define \ :ref:`DTV_STAT_ERROR_BLOCK_COUNT <dtv-stat-error-block-count>`      68
    \#define \ :ref:`DTV_STAT_TOTAL_BLOCK_COUNT <dtv-stat-total-block-count>`      69

    \/\* Physical layer scrambling \*\/
    \#define \ :ref:`DTV_SCRAMBLING_SEQUENCE_INDEX <dtv-scrambling-sequence-index>`   70

    \#define DTV\_MAX\_COMMAND         \ :ref:`DTV_SCRAMBLING_SEQUENCE_INDEX <dtv-scrambling-sequence-index>`

    \/\*\*
     \* enum :c:type:`fe_pilot` - Type of pilot tone
     \*
     \* @PILOT\_ON\:   Pilot tones enabled
     \* @PILOT\_OFF\:  Pilot tones disabled
     \* @PILOT\_AUTO\: Autodetect pilot tones
     \*\/
    enum :c:type:`fe_pilot` \{
            PILOT\_ON,
            PILOT\_OFF,
            PILOT\_AUTO,
    \};

    \/\*\*
     \* enum :c:type:`fe_rolloff` - Rolloff factor
     \* @ROLLOFF\_35\:         Roloff factor\: α=35\%
     \* @ROLLOFF\_20\:         Roloff factor\: α=20\%
     \* @ROLLOFF\_25\:         Roloff factor\: α=25\%
     \* @ROLLOFF\_AUTO\:       Auto-detect the roloff factor.
     \*
     \* .. note\:
     \*
     \*    Roloff factor of 35\% is implied on DVB-S. On DVB-S2, it is default.
     \*\/
    enum :c:type:`fe_rolloff` \{
            ROLLOFF\_35,
            ROLLOFF\_20,
            ROLLOFF\_25,
            ROLLOFF\_AUTO,
    \};

    \/\*\*
     \* enum :c:type:`fe_delivery_system` - Type of the delivery system
     \*
     \* @SYS\_UNDEFINED\:
     \*      Undefined standard. Generally, indicates an error
     \* @SYS\_DVBC\_ANNEX\_A\:
     \*      Cable TV\: DVB-C following ITU-T J.83 Annex A spec
     \* @SYS\_DVBC\_ANNEX\_B\:
     \*      Cable TV\: DVB-C following ITU-T J.83 Annex B spec (ClearQAM)
     \* @SYS\_DVBC\_ANNEX\_C\:
     \*      Cable TV\: DVB-C following ITU-T J.83 Annex C spec
     \* @SYS\_ISDBC\:
     \*      Cable TV\: ISDB-C (no drivers yet)
     \* @SYS\_DVBT\:
     \*      Terrestrial TV\: DVB-T
     \* @SYS\_DVBT2\:
     \*      Terrestrial TV\: DVB-T2
     \* @SYS\_ISDBT\:
     \*      Terrestrial TV\: ISDB-T
     \* @SYS\_ATSC\:
     \*      Terrestrial TV\: ATSC
     \* @SYS\_ATSCMH\:
     \*      Terrestrial TV (mobile)\: ATSC-M\/H
     \* @SYS\_DTMB\:
     \*      Terrestrial TV\: DTMB
     \* @SYS\_DVBS\:
     \*      Satellite TV\: DVB-S
     \* @SYS\_DVBS2\:
     \*      Satellite TV\: DVB-S2
     \* @SYS\_TURBO\:
     \*      Satellite TV\: DVB-S Turbo
     \* @SYS\_ISDBS\:
     \*      Satellite TV\: ISDB-S
     \* @SYS\_DAB\:
     \*      Digital audio\: DAB (not fully supported)
     \* @SYS\_DSS\:
     \*      Satellite TV\: DSS (not fully supported)
     \* @SYS\_CMMB\:
     \*      Terrestrial TV (mobile)\: CMMB (not fully supported)
     \* @SYS\_DVBH\:
     \*      Terrestrial TV (mobile)\: DVB-H (standard deprecated)
     \*\/
    enum :c:type:`fe_delivery_system` \{
            SYS\_UNDEFINED,
            SYS\_DVBC\_ANNEX\_A,
            SYS\_DVBC\_ANNEX\_B,
            SYS\_DVBT,
            SYS\_DSS,
            SYS\_DVBS,
            SYS\_DVBS2,
            SYS\_DVBH,
            SYS\_ISDBT,
            SYS\_ISDBS,
            SYS\_ISDBC,
            SYS\_ATSC,
            SYS\_ATSCMH,
            SYS\_DTMB,
            SYS\_CMMB,
            SYS\_DAB,
            SYS\_DVBT2,
            SYS\_TURBO,
            SYS\_DVBC\_ANNEX\_C,
    \};

    \/\* backward compatibility definitions for delivery systems \*\/
    \#define SYS\_DVBC\_ANNEX\_AC       SYS\_DVBC\_ANNEX\_A
    \#define SYS\_DMBTH               SYS\_DTMB \/\* DMB-TH is legacy name, use DTMB \*\/

    \/\* ATSC-MH specific parameters \*\/

    \/\*\*
     \* enum :c:type:`atscmh_sccc_block_mode` - Type of Series Concatenated Convolutional
     \*                               Code Block Mode.
     \*
     \* @ATSCMH\_SCCC\_BLK\_SEP\:
     \*      Separate SCCC\: the SCCC outer code mode shall be set independently
     \*      for each Group Region (A, B, C, D)
     \* @ATSCMH\_SCCC\_BLK\_COMB\:
     \*      Combined SCCC\: all four Regions shall have the same SCCC outer
     \*      code mode.
     \* @ATSCMH\_SCCC\_BLK\_RES\:
     \*      Reserved. Shouldn't be used.
     \*\/
    enum :c:type:`atscmh_sccc_block_mode` \{
            ATSCMH\_SCCC\_BLK\_SEP      = 0,
            ATSCMH\_SCCC\_BLK\_COMB     = 1,
            ATSCMH\_SCCC\_BLK\_RES      = 2,
    \};

    \/\*\*
     \* enum :c:type:`atscmh_sccc_code_mode` - Type of Series Concatenated Convolutional
     \*                              Code Rate.
     \*
     \* @ATSCMH\_SCCC\_CODE\_HLF\:
     \*      The outer code rate of a SCCC Block is 1\/2 rate.
     \* @ATSCMH\_SCCC\_CODE\_QTR\:
     \*      The outer code rate of a SCCC Block is 1\/4 rate.
     \* @ATSCMH\_SCCC\_CODE\_RES\:
     \*      Reserved. Should not be used.
     \*\/
    enum :c:type:`atscmh_sccc_code_mode` \{
            ATSCMH\_SCCC\_CODE\_HLF     = 0,
            ATSCMH\_SCCC\_CODE\_QTR     = 1,
            ATSCMH\_SCCC\_CODE\_RES     = 2,
    \};

    \/\*\*
     \* enum :c:type:`atscmh_rs_frame_ensemble` - Reed Solomon(RS) frame ensemble.
     \*
     \* @ATSCMH\_RSFRAME\_ENS\_PRI\:     Primary Ensemble.
     \* @ATSCMH\_RSFRAME\_ENS\_SEC\:     Secondary Ensemble.
     \*\/
    enum :c:type:`atscmh_rs_frame_ensemble` \{
            ATSCMH\_RSFRAME\_ENS\_PRI   = 0,
            ATSCMH\_RSFRAME\_ENS\_SEC   = 1,
    \};

    \/\*\*
     \* enum :c:type:`atscmh_rs_frame_mode` - Reed Solomon (RS) frame mode.
     \*
     \* @ATSCMH\_RSFRAME\_PRI\_ONLY\:
     \*      Single Frame\: There is only a primary RS Frame for all Group
     \*      Regions.
     \* @ATSCMH\_RSFRAME\_PRI\_SEC\:
     \*      Dual Frame\: There are two separate RS Frames\: Primary RS Frame for
     \*      Group Region A and B and Secondary RS Frame for Group Region C and
     \*      D.
     \* @ATSCMH\_RSFRAME\_RES\:
     \*      Reserved. Shouldn't be used.
     \*\/
    enum :c:type:`atscmh_rs_frame_mode` \{
            ATSCMH\_RSFRAME\_PRI\_ONLY  = 0,
            ATSCMH\_RSFRAME\_PRI\_SEC   = 1,
            ATSCMH\_RSFRAME\_RES       = 2,
    \};

    \/\*\*
     \* enum :c:type:`atscmh_rs_code_mode`
     \* @ATSCMH\_RSCODE\_211\_187\:      Reed Solomon code (211,187).
     \* @ATSCMH\_RSCODE\_223\_187\:      Reed Solomon code (223,187).
     \* @ATSCMH\_RSCODE\_235\_187\:      Reed Solomon code (235,187).
     \* @ATSCMH\_RSCODE\_RES\:          Reserved. Shouldn't be used.
     \*\/
    enum :c:type:`atscmh_rs_code_mode` \{
            ATSCMH\_RSCODE\_211\_187    = 0,
            ATSCMH\_RSCODE\_223\_187    = 1,
            ATSCMH\_RSCODE\_235\_187    = 2,
            ATSCMH\_RSCODE\_RES        = 3,
    \};

    \#define :ref:`NO_STREAM_ID_FILTER <dtv-stream-id>`     (\~0U)
    \#define :ref:`LNA_AUTO <dtv-lna>`                (\~0U)

    \/\*\*
     \* enum :c:type:`fecap_scale_params` - scale types for the quality parameters.
     \*
     \* @FE\_SCALE\_NOT\_AVAILABLE\: That QoS measure is not available. That
     \*                          could indicate a temporary or a permanent
     \*                          condition.
     \* @FE\_SCALE\_DECIBEL\: The scale is measured in 0.001 dB steps, typically
     \*                    used on signal measures.
     \* @FE\_SCALE\_RELATIVE\: The scale is a relative percentual measure,
     \*                     ranging from 0 (0\%) to 0xffff (100\%).
     \* @FE\_SCALE\_COUNTER\: The scale counts the occurrence of an event, like
     \*                    bit error, block error, lapsed time.
     \*\/
    enum :c:type:`fecap_scale_params` \{
            FE\_SCALE\_NOT\_AVAILABLE = 0,
            FE\_SCALE\_DECIBEL,
            FE\_SCALE\_RELATIVE,
            FE\_SCALE\_COUNTER
    \};

    \/\*\*
     \* struct dtv_stats - Used for reading a DTV status property
     \*
     \* @scale\:
     \*      Filled with enum :c:type:`fecap_scale_params` - the scale in usage
     \*      for that parameter
     \*
     \* @svalue\:
     \*      integer value of the measure, for \%FE\_SCALE\_DECIBEL,
     \*      used for dB measures. The unit is 0.001 dB.
     \*
     \* @uvalue\:
     \*      unsigned integer value of the measure, used when @scale is
     \*      either \%FE\_SCALE\_RELATIVE or \%FE\_SCALE\_COUNTER.
     \*
     \* For most delivery systems, this will return a single value for each
     \* parameter.
     \*
     \* It should be noticed, however, that new OFDM delivery systems like
     \* ISDB can use different modulation types for each group of carriers.
     \* On such standards, up to 8 groups of statistics can be provided, one
     \* for each carrier group (called "layer" on ISDB).
     \*
     \* In order to be consistent with other delivery systems, the first
     \* value refers to the entire set of carriers ("global").
     \*
     \* @scale should use the value \%FE\_SCALE\_NOT\_AVAILABLE when
     \* the value for the entire group of carriers or from one specific layer
     \* is not provided by the hardware.
     \*
     \* @len should be filled with the latest filled status + 1.
     \*
     \* In other words, for ISDB, those values should be filled like\:\:
     \*
     \*      u.st.stat.svalue[0] = global statistics;
     \*      u.st.stat.scale[0] = FE\_SCALE\_DECIBEL;
     \*      u.st.stat.value[1] = layer A statistics;
     \*      u.st.stat.scale[1] = FE\_SCALE\_NOT\_AVAILABLE (if not available);
     \*      u.st.stat.svalue[2] = layer B statistics;
     \*      u.st.stat.scale[2] = FE\_SCALE\_DECIBEL;
     \*      u.st.stat.svalue[3] = layer C statistics;
     \*      u.st.stat.scale[3] = FE\_SCALE\_DECIBEL;
     \*      u.st.len = 4;
     \*\/
    struct dtv_stats \{
            \_\_u8 scale;     \/\* enum :c:type:`fecap_scale_params` type \*\/
            union \{
                    \_\_u64 uvalue;   \/\* for counters and relative scales \*\/
                    \_\_s64 svalue;   \/\* for 0.001 dB measures \*\/
            \};
    \} \_\_attribute\_\_ ((packed));

    \#define MAX\_DTV\_STATS   4

    \/\*\*
     \* struct dtv_fe_stats - store Digital TV frontend statistics
     \*
     \* @len\:        length of the statistics - if zero, stats is disabled.
     \* @stat\:       array with digital TV statistics.
     \*
     \* On most standards, @len can either be 0 or 1. However, for ISDB, each
     \* layer is modulated in separate. So, each layer may have its own set
     \* of statistics. If so, stat[0] carries on a global value for the property.
     \* Indexes 1 to 3 means layer A to B.
     \*\/
    struct dtv_fe_stats \{
            \_\_u8 len;
            struct dtv_stats stat[MAX\_DTV\_STATS];
    \} \_\_attribute\_\_ ((packed));

    \/\*\*
     \* struct dtv_property - store one of frontend command and its value
     \*
     \* @cmd\:                Digital TV command.
     \* @reserved\:           Not used.
     \* @u\:                  Union with the values for the command.
     \* @u.data\:             A unsigned 32 bits integer with command value.
     \* @u.buffer\:           Struct to store bigger properties.
     \*                      Currently unused.
     \* @u.buffer.data\:      an unsigned 32-bits array.
     \* @u.buffer.len\:       number of elements of the buffer.
     \* @u.buffer.reserved1\: Reserved.
     \* @u.buffer.reserved2\: Reserved.
     \* @u.st\:               a \&struct dtv_fe_stats array of statistics.
     \* @result\:             Currently unused.
     \*
     \*\/
    struct dtv_property \{
            \_\_u32 cmd;
            \_\_u32 reserved[3];
            union \{
                    \_\_u32 data;
                    struct dtv_fe_stats st;
                    struct \{
                            \_\_u8 data[32];
                            \_\_u32 len;
                            \_\_u32 reserved1[3];
                            void \*reserved2;
                    \} buffer;
            \} u;
            int result;
    \} \_\_attribute\_\_ ((packed));

    \/\* num of properties cannot exceed DTV\_IOCTL\_MAX\_MSGS per ioctl \*\/
    \#define DTV\_IOCTL\_MAX\_MSGS 64

    \/\*\*
     \* struct dtv_properties - a set of command\/value pairs.
     \*
     \* @num\:        amount of commands stored at the struct.
     \* @props\:      a pointer to \&struct dtv\_property.
     \*\/
    struct dtv_properties \{
            \_\_u32 num;
            struct dtv_property \*props;
    \};

    \/\*
     \* When set, this flag will disable any zigzagging or other "normal" tuning
     \* behavior. Additionally, there will be no automatic monitoring of the lock
     \* status, and hence no frontend events will be generated. If a frontend device
     \* is closed, this flag will be automatically turned off when the device is
     \* reopened read-write.
     \*\/
    \#define :c:func:`FE_TUNE_MODE_ONESHOT <FE_SET_FRONTEND_TUNE_MODE>` 0x01

    \/\* Digital TV Frontend API calls \*\/

    \#define \ :ref:`FE_GET_INFO <fe_get_info>`                \_IOR('o', 61, struct dvb_frontend_info\ )

    \#define \ :ref:`FE_DISEQC_RESET_OVERLOAD <fe_diseqc_reset_overload>`   \_IO('o', 62)
    \#define \ :ref:`FE_DISEQC_SEND_MASTER_CMD <fe_diseqc_send_master_cmd>`  \_IOW('o', 63, struct dvb_diseqc_master_cmd\ )
    \#define \ :ref:`FE_DISEQC_RECV_SLAVE_REPLY <fe_diseqc_recv_slave_reply>` \_IOR('o', 64, struct dvb_diseqc_slave_reply\ )
    \#define \ :ref:`FE_DISEQC_SEND_BURST <fe_diseqc_send_burst>`       \_IO('o', 65)  \/\* \ :c:type:`fe_sec_mini_cmd_t <fe_sec_mini_cmd>` \*\/

    \#define \ :ref:`FE_SET_TONE <fe_set_tone>`                \_IO('o', 66)  \/\* \ :c:type:`fe_sec_tone_mode_t <fe_sec_tone_mode>` \*\/
    \#define \ :ref:`FE_SET_VOLTAGE <fe_set_voltage>`             \_IO('o', 67)  \/\* :c:type:`fe_sec_voltage_t <fe_sec_voltage>` \*\/
    \#define \ :ref:`FE_ENABLE_HIGH_LNB_VOLTAGE <fe_enable_high_lnb_voltage>` \_IO('o', 68)  \/\* int \*\/

    \#define \ :ref:`FE_READ_STATUS <fe_read_status>`             \_IOR('o', 69, \ :c:type:`fe_status_t <fe_status>`\ )
    \#define \ :ref:`FE_READ_BER <fe_read_ber>`                \_IOR('o', 70, \_\_u32)
    \#define \ :ref:`FE_READ_SIGNAL_STRENGTH <fe_read_signal_strength>`    \_IOR('o', 71, \_\_u16)
    \#define \ :ref:`FE_READ_SNR <fe_read_snr>`                \_IOR('o', 72, \_\_u16)
    \#define \ :ref:`FE_READ_UNCORRECTED_BLOCKS <fe_read_uncorrected_blocks>` \_IOR('o', 73, \_\_u32)

    \#define \ :ref:`FE_SET_FRONTEND_TUNE_MODE <fe_set_frontend_tune_mode>`  \_IO('o', 81) \/\* unsigned int \*\/
    \#define \ :ref:`FE_GET_EVENT <fe_get_event>`               \_IOR('o', 78, struct dvb_frontend_event\ )

    \#define \ :ref:`FE_DISHNETWORK_SEND_LEGACY_CMD <fe_dishnetwork_send_legacy_cmd>` \_IO('o', 80) \/\* unsigned int \*\/

    \#define :c:type:`FE_SET_PROPERTY <FE_GET_PROPERTY>`            \_IOW('o', 82, struct dtv_properties\ )
    \#define \ :ref:`FE_GET_PROPERTY <fe_get_property>`            \_IOR('o', 83, struct dtv_properties\ )

    \#if defined(\_\_DVB\_CORE\_\_) \|\| !defined(\_\_KERNEL\_\_)

    \/\*
     \* **DEPRECATED**\: Everything below is deprecated in favor of DVBv5 API
     \*
     \* The DVBv3 only ioctls, structs and enums should not be used on
     \* newer programs, as it doesn't support the second generation of
     \* digital TV standards, nor supports newer delivery systems.
     \* They also don't support modern frontends with usually support multiple
     \* delivery systems.
     \*
     \* Drivers shouldn't use them.
     \*
     \* New applications should use DVBv5 delivery system instead
     \*\/

    \/\*
     \*\/

    enum :c:type:`fe_bandwidth` \{
            \ :ref:`BANDWIDTH_8_MHZ <bandwidth-8-mhz>`\ ,
            \ :ref:`BANDWIDTH_7_MHZ <bandwidth-7-mhz>`\ ,
            \ :ref:`BANDWIDTH_6_MHZ <bandwidth-6-mhz>`\ ,
            \ :ref:`BANDWIDTH_AUTO <bandwidth-auto>`\ ,
            \ :ref:`BANDWIDTH_5_MHZ <bandwidth-5-mhz>`\ ,
            \ :ref:`BANDWIDTH_10_MHZ <bandwidth-10-mhz>`\ ,
            \ :ref:`BANDWIDTH_1_712_MHZ <bandwidth-1-712-mhz>`\ ,
    \};

    \/\* This is kept for legacy userspace support \*\/
    typedef enum :c:type:`fe_sec_voltage` :c:type:`fe_sec_voltage_t <fe_sec_voltage>`;
    typedef enum :c:type:`fe_caps` \ :c:type:`fe_caps_t <fe_caps>`\ ;
    typedef enum :c:type:`fe_type` \ :c:type:`fe_type_t <fe_type>`\ ;
    typedef enum :c:type:`fe_sec_tone_mode` \ :c:type:`fe_sec_tone_mode_t <fe_sec_tone_mode>`\ ;
    typedef enum :c:type:`fe_sec_mini_cmd` \ :c:type:`fe_sec_mini_cmd_t <fe_sec_mini_cmd>`\ ;
    typedef enum :c:type:`fe_status` \ :c:type:`fe_status_t <fe_status>`\ ;
    typedef enum :c:type:`fe_spectral_inversion` \ :c:type:`fe_spectral_inversion_t <fe_spectral_inversion>`\ ;
    typedef enum :c:type:`fe_code_rate` \ :c:type:`fe_code_rate_t <fe_code_rate>`\ ;
    typedef enum :c:type:`fe_modulation` \ :c:type:`fe_modulation_t <fe_modulation>`\ ;
    typedef enum :c:type:`fe_transmit_mode` \ :c:type:`fe_transmit_mode_t <fe_transmit_mode>`\ ;
    typedef enum :c:type:`fe_bandwidth` \ :c:type:`fe_bandwidth_t <fe_bandwidth>`\ ;
    typedef enum :c:type:`fe_guard_interval` \ :c:type:`fe_guard_interval_t <fe_guard_interval>`\ ;
    typedef enum :c:type:`fe_hierarchy` \ :c:type:`fe_hierarchy_t <fe_hierarchy>`\ ;
    typedef enum :c:type:`fe_pilot` \ :c:type:`fe_pilot_t <fe_pilot>`\ ;
    typedef enum :c:type:`fe_rolloff` \ :c:type:`fe_rolloff_t <fe_rolloff>`\ ;
    typedef enum :c:type:`fe_delivery_system` \ :c:type:`fe_delivery_system_t <fe_delivery_system>`\ ;

    \/\* DVBv3 structs \*\/

    struct dvb_qpsk_parameters \{
            \_\_u32           symbol\_rate;  \/\* symbol rate in Symbols per second \*\/
            \ :c:type:`fe_code_rate_t <fe_code_rate>`  fec\_inner;    \/\* forward error correction (see above) \*\/
    \};

    struct dvb_qam_parameters \{
            \_\_u32           symbol\_rate; \/\* symbol rate in Symbols per second \*\/
            \ :c:type:`fe_code_rate_t <fe_code_rate>`  fec\_inner;   \/\* forward error correction (see above) \*\/
            \ :c:type:`fe_modulation_t <fe_modulation>` modulation;  \/\* modulation type (see above) \*\/
    \};

    struct dvb_vsb_parameters \{
            \ :c:type:`fe_modulation_t <fe_modulation>` modulation;  \/\* modulation type (see above) \*\/
    \};

    struct dvb_ofdm_parameters \{
            \ :c:type:`fe_bandwidth_t <fe_bandwidth>`      bandwidth;
            \ :c:type:`fe_code_rate_t <fe_code_rate>`      code\_rate\_HP;  \/\* high priority stream code rate \*\/
            \ :c:type:`fe_code_rate_t <fe_code_rate>`      code\_rate\_LP;  \/\* low priority stream code rate \*\/
            \ :c:type:`fe_modulation_t <fe_modulation>`     constellation; \/\* modulation type (see above) \*\/
            \ :c:type:`fe_transmit_mode_t <fe_transmit_mode>`  transmission\_mode;
            \ :c:type:`fe_guard_interval_t <fe_guard_interval>` guard\_interval;
            \ :c:type:`fe_hierarchy_t <fe_hierarchy>`      hierarchy\_information;
    \};

    struct dvb_frontend_parameters \{
            \_\_u32 frequency;  \/\* (absolute) frequency in Hz for DVB-C\/DVB-T\/ATSC \*\/
                              \/\* intermediate frequency in kHz for DVB-S \*\/
            \ :c:type:`fe_spectral_inversion_t <fe_spectral_inversion>` inversion;
            union \{
                    struct dvb_qpsk_parameters qpsk;        \/\* DVB-S \*\/
                    struct dvb_qam_parameters  qam;         \/\* DVB-C \*\/
                    struct dvb_ofdm_parameters ofdm;        \/\* DVB-T \*\/
                    struct dvb_vsb_parameters vsb;          \/\* ATSC \*\/
            \} u;
    \};

    struct dvb_frontend_event \{
            \ :c:type:`fe_status_t <fe_status>` status;
            struct dvb_frontend_parameters parameters;
    \};

    \/\* DVBv3 API calls \*\/

    \#define \ :ref:`FE_SET_FRONTEND <fe_set_frontend>`            \_IOW('o', 76, struct dvb_frontend_parameters\ )
    \#define \ :ref:`FE_GET_FRONTEND <fe_get_frontend>`            \_IOR('o', 77, struct dvb_frontend_parameters\ )

    \#endif

    \#endif \/\*\_DVBFRONTEND\_H\_\*\/
