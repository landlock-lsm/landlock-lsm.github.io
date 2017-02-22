.. -*- coding: utf-8; mode: rst -*-

frontend.h
==========

.. parsed-literal::

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

    enum :c:type:`fe_type` \{
            \ :ref:`FE_QPSK <fe-qpsk>`\ ,
            \ :ref:`FE_QAM <fe-qam>`\ ,
            \ :ref:`FE_OFDM <fe-ofdm>`\ ,
            \ :ref:`FE_ATSC <fe-atsc>`
    \};

    enum :c:type:`fe_caps` \{
            \ :ref:`FE_IS_STUPID <fe-is-stupid>`                    = 0,
            \ :ref:`FE_CAN_INVERSION_AUTO <fe-can-inversion-auto>`           = 0x1,
            \ :ref:`FE_CAN_FEC_1_2 <fe-can-fec-1-2>`                  = 0x2,
            \ :ref:`FE_CAN_FEC_2_3 <fe-can-fec-2-3>`                  = 0x4,
            \ :ref:`FE_CAN_FEC_3_4 <fe-can-fec-3-4>`                  = 0x8,
            \ :ref:`FE_CAN_FEC_4_5 <fe-can-fec-4-5>`                  = 0x10,
            \ :ref:`FE_CAN_FEC_5_6 <fe-can-fec-5-6>`                  = 0x20,
            \ :ref:`FE_CAN_FEC_6_7 <fe-can-fec-6-7>`                  = 0x40,
            \ :ref:`FE_CAN_FEC_7_8 <fe-can-fec-7-8>`                  = 0x80,
            \ :ref:`FE_CAN_FEC_8_9 <fe-can-fec-8-9>`                  = 0x100,
            \ :ref:`FE_CAN_FEC_AUTO <fe-can-fec-auto>`                 = 0x200,
            \ :ref:`FE_CAN_QPSK <fe-can-qpsk>`                     = 0x400,
            \ :ref:`FE_CAN_QAM_16 <fe-can-qam-16>`                   = 0x800,
            \ :ref:`FE_CAN_QAM_32 <fe-can-qam-32>`                   = 0x1000,
            \ :ref:`FE_CAN_QAM_64 <fe-can-qam-64>`                   = 0x2000,
            \ :ref:`FE_CAN_QAM_128 <fe-can-qam-128>`                  = 0x4000,
            \ :ref:`FE_CAN_QAM_256 <fe-can-qam-256>`                  = 0x8000,
            \ :ref:`FE_CAN_QAM_AUTO <fe-can-qam-auto>`                 = 0x10000,
            \ :ref:`FE_CAN_TRANSMISSION_MODE_AUTO <fe-can-transmission-mode-auto>`   = 0x20000,
            \ :ref:`FE_CAN_BANDWIDTH_AUTO <fe-can-bandwidth-auto>`           = 0x40000,
            \ :ref:`FE_CAN_GUARD_INTERVAL_AUTO <fe-can-guard-interval-auto>`      = 0x80000,
            \ :ref:`FE_CAN_HIERARCHY_AUTO <fe-can-hierarchy-auto>`           = 0x100000,
            \ :ref:`FE_CAN_8VSB <fe-can-8vsb>`                     = 0x200000,
            \ :ref:`FE_CAN_16VSB <fe-can-16vsb>`                    = 0x400000,
            \ :ref:`FE_HAS_EXTENDED_CAPS <fe-has-extended-caps>`            = 0x800000,   \/\* We need more bitspace for newer APIs, indicate this. \*\/
            \ :ref:`FE_CAN_MULTISTREAM <fe-can-multistream>`              = 0x4000000,  \/\* frontend supports multistream filtering \*\/
            \ :ref:`FE_CAN_TURBO_FEC <fe-can-turbo-fec>`                = 0x8000000,  \/\* frontend supports "turbo fec modulation" \*\/
            \ :ref:`FE_CAN_2G_MODULATION <fe-can-2g-modulation>`            = 0x10000000, \/\* frontend supports "2nd generation modulation" (DVB-S2) \*\/
            \ :ref:`FE_NEEDS_BENDING <fe-needs-bending>`                = 0x20000000, \/\* not supported anymore, don't use (frontend requires frequency bending) \*\/
            \ :ref:`FE_CAN_RECOVER <fe-can-recover>`                  = 0x40000000, \/\* frontend can recover from a cable unplug automatically \*\/
            \ :ref:`FE_CAN_MUTE_TS <fe-can-mute-ts>`                  = 0x80000000  \/\* frontend can stop spurious TS data output \*\/
    \};

    struct :c:type:`dvb_frontend_info` \{
            char       name[128];
            enum :c:type:`fe_type` type;      \/\* **DEPRECATED**. Use \ :ref:`DTV_ENUM_DELSYS <dtv-enum-delsys>` instead \*\/
            \_\_u32      frequency\_min;
            \_\_u32      frequency\_max;
            \_\_u32      frequency\_stepsize;
            \_\_u32      frequency\_tolerance;
            \_\_u32      symbol\_rate\_min;
            \_\_u32      symbol\_rate\_max;
            \_\_u32      symbol\_rate\_tolerance;       \/\* ppm \*\/
            \_\_u32      notifier\_delay;              \/\* **DEPRECATED** \*\/
            enum :c:type:`fe_caps` caps;
    \};

    \/\*\*
     \*  Check out the DiSEqC bus spec available on http\:\/\/www.eutelsat.org\/ for
     \*  the meaning of this struct...
     \*\/
    struct :c:type:`dvb_diseqc_master_cmd` \{
            \_\_u8 msg [6];   \/\*  \{ framing, address, command, data [3] \} \*\/
            \_\_u8 msg\_len;   \/\*  valid values are 3...6  \*\/
    \};

    struct :c:type:`dvb_diseqc_slave_reply` \{
            \_\_u8 msg [4];   \/\*  \{ framing, data [3] \} \*\/
            \_\_u8 msg\_len;   \/\*  valid values are 0...4, 0 means no msg  \*\/
            int  timeout;   \/\*  return from ioctl after timeout ms with \*\/
    \};                      \/\*  errorcode when no message was received  \*\/

    enum :c:type:`fe_sec_voltage` \{
            \ :ref:`SEC_VOLTAGE_13 <sec-voltage-13>`\ ,
            \ :ref:`SEC_VOLTAGE_18 <sec-voltage-18>`\ ,
            \ :ref:`SEC_VOLTAGE_OFF <sec-voltage-off>`
    \};

    enum :c:type:`fe_sec_tone_mode` \{
            \ :ref:`SEC_TONE_ON <sec-tone-on>`\ ,
            \ :ref:`SEC_TONE_OFF <sec-tone-off>`
    \};

    enum :c:type:`fe_sec_mini_cmd` \{
            \ :ref:`SEC_MINI_A <sec-mini-a>`\ ,
            \ :ref:`SEC_MINI_B <sec-mini-b>`
    \};

    \/\*\*
     \* enum :c:type:`fe_status` - enumerates the possible frontend status
     \* @\ :ref:`FE_HAS_SIGNAL <fe-has-signal>`\ \:      found something above the noise level
     \* @\ :ref:`FE_HAS_CARRIER <fe-has-carrier>`\ \:     found a DVB signal
     \* @\ :ref:`FE_HAS_VITERBI <fe-has-viterbi>`\ \:     FEC is stable
     \* @\ :ref:`FE_HAS_SYNC <fe-has-sync>`\ \:        found sync bytes
     \* @\ :ref:`FE_HAS_LOCK <fe-has-lock>`\ \:        everything's working
     \* @\ :ref:`FE_TIMEDOUT <fe-timedout>`\ \:        no lock within the last \~2 seconds
     \* @\ :ref:`FE_REINIT <fe-reinit>`\ \:          frontend was reinitialized, application is recommended
     \*                      to reset DiSEqC, tone and parameters
     \*\/
    enum :c:type:`fe_status` \{
            \ :ref:`FE_HAS_SIGNAL <fe-has-signal>`           = 0x01,
            \ :ref:`FE_HAS_CARRIER <fe-has-carrier>`          = 0x02,
            \ :ref:`FE_HAS_VITERBI <fe-has-viterbi>`          = 0x04,
            \ :ref:`FE_HAS_SYNC <fe-has-sync>`             = 0x08,
            \ :ref:`FE_HAS_LOCK <fe-has-lock>`             = 0x10,
            \ :ref:`FE_TIMEDOUT <fe-timedout>`             = 0x20,
            \ :ref:`FE_REINIT <fe-reinit>`               = 0x40,
    \};

    enum :c:type:`fe_spectral_inversion` \{
            \ :ref:`INVERSION_OFF <inversion-off>`\ ,
            \ :ref:`INVERSION_ON <inversion-on>`\ ,
            \ :ref:`INVERSION_AUTO <inversion-auto>`
    \};

    enum :c:type:`fe_code_rate` \{
            \ :ref:`FEC_NONE <fec-none>` = 0,
            \ :ref:`FEC_1_2 <fec-1-2>`\ ,
            \ :ref:`FEC_2_3 <fec-2-3>`\ ,
            \ :ref:`FEC_3_4 <fec-3-4>`\ ,
            \ :ref:`FEC_4_5 <fec-4-5>`\ ,
            \ :ref:`FEC_5_6 <fec-5-6>`\ ,
            \ :ref:`FEC_6_7 <fec-6-7>`\ ,
            \ :ref:`FEC_7_8 <fec-7-8>`\ ,
            \ :ref:`FEC_8_9 <fec-8-9>`\ ,
            \ :ref:`FEC_AUTO <fec-auto>`\ ,
            \ :ref:`FEC_3_5 <fec-3-5>`\ ,
            \ :ref:`FEC_9_10 <fec-9-10>`\ ,
            \ :ref:`FEC_2_5 <fec-2-5>`\ ,
    \};

    enum :c:type:`fe_modulation` \{
            \ :ref:`QPSK <qpsk>`\ ,
            \ :ref:`QAM_16 <qam-16>`\ ,
            \ :ref:`QAM_32 <qam-32>`\ ,
            \ :ref:`QAM_64 <qam-64>`\ ,
            \ :ref:`QAM_128 <qam-128>`\ ,
            \ :ref:`QAM_256 <qam-256>`\ ,
            \ :ref:`QAM_AUTO <qam-auto>`\ ,
            \ :ref:`VSB_8 <vsb-8>`\ ,
            \ :ref:`VSB_16 <vsb-16>`\ ,
            \ :ref:`PSK_8 <psk-8>`\ ,
            \ :ref:`APSK_16 <apsk-16>`\ ,
            \ :ref:`APSK_32 <apsk-32>`\ ,
            \ :ref:`DQPSK <dqpsk>`\ ,
            \ :ref:`QAM_4_NR <qam-4-nr>`\ ,
    \};

    enum :c:type:`fe_transmit_mode` \{
            \ :ref:`TRANSMISSION_MODE_2K <transmission-mode-2k>`\ ,
            \ :ref:`TRANSMISSION_MODE_8K <transmission-mode-8k>`\ ,
            \ :ref:`TRANSMISSION_MODE_AUTO <transmission-mode-auto>`\ ,
            \ :ref:`TRANSMISSION_MODE_4K <transmission-mode-4k>`\ ,
            \ :ref:`TRANSMISSION_MODE_1K <transmission-mode-1k>`\ ,
            \ :ref:`TRANSMISSION_MODE_16K <transmission-mode-16k>`\ ,
            \ :ref:`TRANSMISSION_MODE_32K <transmission-mode-32k>`\ ,
            \ :ref:`TRANSMISSION_MODE_C1 <transmission-mode-c1>`\ ,
            \ :ref:`TRANSMISSION_MODE_C3780 <transmission-mode-c3780>`\ ,
    \};

    enum :c:type:`fe_guard_interval` \{
            \ :ref:`GUARD_INTERVAL_1_32 <guard-interval-1-32>`\ ,
            \ :ref:`GUARD_INTERVAL_1_16 <guard-interval-1-16>`\ ,
            \ :ref:`GUARD_INTERVAL_1_8 <guard-interval-1-8>`\ ,
            \ :ref:`GUARD_INTERVAL_1_4 <guard-interval-1-4>`\ ,
            \ :ref:`GUARD_INTERVAL_AUTO <guard-interval-auto>`\ ,
            \ :ref:`GUARD_INTERVAL_1_128 <guard-interval-1-128>`\ ,
            \ :ref:`GUARD_INTERVAL_19_128 <guard-interval-19-128>`\ ,
            \ :ref:`GUARD_INTERVAL_19_256 <guard-interval-19-256>`\ ,
            \ :ref:`GUARD_INTERVAL_PN420 <guard-interval-pn420>`\ ,
            \ :ref:`GUARD_INTERVAL_PN595 <guard-interval-pn595>`\ ,
            \ :ref:`GUARD_INTERVAL_PN945 <guard-interval-pn945>`\ ,
    \};

    enum :c:type:`fe_hierarchy` \{
            \ :ref:`HIERARCHY_NONE <hierarchy-none>`\ ,
            \ :ref:`HIERARCHY_1 <hierarchy-1>`\ ,
            \ :ref:`HIERARCHY_2 <hierarchy-2>`\ ,
            \ :ref:`HIERARCHY_4 <hierarchy-4>`\ ,
            \ :ref:`HIERARCHY_AUTO <hierarchy-auto>`
    \};

    enum :c:type:`fe_interleaving` \{
            \ :ref:`INTERLEAVING_NONE <interleaving-none>`\ ,
            \ :ref:`INTERLEAVING_AUTO <interleaving-auto>`\ ,
            \ :ref:`INTERLEAVING_240 <interleaving-240>`\ ,
            \ :ref:`INTERLEAVING_720 <interleaving-720>`\ ,
    \};

    \/\* S2API Commands \*\/
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

    \#define DTV\_MAX\_COMMAND         \ :ref:`DTV_STAT_TOTAL_BLOCK_COUNT <dtv-stat-total-block-count>`

    enum :c:type:`fe_pilot` \{
            \ :ref:`PILOT_ON <pilot-on>`\ ,
            \ :ref:`PILOT_OFF <pilot-off>`\ ,
            \ :ref:`PILOT_AUTO <pilot-auto>`\ ,
    \};

    enum :c:type:`fe_rolloff` \{
            \ :ref:`ROLLOFF_35 <rolloff-35>`\ , \/\* Implied value in DVB-S, default for DVB-S2 \*\/
            \ :ref:`ROLLOFF_20 <rolloff-20>`\ ,
            \ :ref:`ROLLOFF_25 <rolloff-25>`\ ,
            \ :ref:`ROLLOFF_AUTO <rolloff-auto>`\ ,
    \};

    enum :c:type:`fe_delivery_system` \{
            \ :ref:`SYS_UNDEFINED <sys-undefined>`\ ,
            \ :ref:`SYS_DVBC_ANNEX_A <sys-dvbc-annex-a>`\ ,
            \ :ref:`SYS_DVBC_ANNEX_B <sys-dvbc-annex-b>`\ ,
            \ :ref:`SYS_DVBT <sys-dvbt>`\ ,
            \ :ref:`SYS_DSS <sys-dss>`\ ,
            \ :ref:`SYS_DVBS <sys-dvbs>`\ ,
            \ :ref:`SYS_DVBS2 <sys-dvbs2>`\ ,
            \ :ref:`SYS_DVBH <sys-dvbh>`\ ,
            \ :ref:`SYS_ISDBT <sys-isdbt>`\ ,
            \ :ref:`SYS_ISDBS <sys-isdbs>`\ ,
            \ :ref:`SYS_ISDBC <sys-isdbc>`\ ,
            \ :ref:`SYS_ATSC <sys-atsc>`\ ,
            \ :ref:`SYS_ATSCMH <sys-atscmh>`\ ,
            \ :ref:`SYS_DTMB <sys-dtmb>`\ ,
            \ :ref:`SYS_CMMB <sys-cmmb>`\ ,
            \ :ref:`SYS_DAB <sys-dab>`\ ,
            \ :ref:`SYS_DVBT2 <sys-dvbt2>`\ ,
            \ :ref:`SYS_TURBO <sys-turbo>`\ ,
            \ :ref:`SYS_DVBC_ANNEX_C <sys-dvbc-annex-c>`\ ,
    \};

    \/\* backward compatibility \*\/
    \#define SYS\_DVBC\_ANNEX\_AC       \ :ref:`SYS_DVBC_ANNEX_A <sys-dvbc-annex-a>`
    \#define SYS\_DMBTH \ :ref:`SYS_DTMB <sys-dtmb>` \/\* DMB-TH is legacy name, use DTMB instead \*\/

    \/\* ATSC-MH \*\/

    enum :c:type:`atscmh_sccc_block_mode` \{
            \ :ref:`ATSCMH_SCCC_BLK_SEP <atscmh-sccc-blk-sep>`      = 0,
            \ :ref:`ATSCMH_SCCC_BLK_COMB <atscmh-sccc-blk-comb>`     = 1,
            \ :ref:`ATSCMH_SCCC_BLK_RES <atscmh-sccc-blk-res>`      = 2,
    \};

    enum :c:type:`atscmh_sccc_code_mode` \{
            \ :ref:`ATSCMH_SCCC_CODE_HLF <atscmh-sccc-code-hlf>`     = 0,
            \ :ref:`ATSCMH_SCCC_CODE_QTR <atscmh-sccc-code-qtr>`     = 1,
            \ :ref:`ATSCMH_SCCC_CODE_RES <atscmh-sccc-code-res>`     = 2,
    \};

    enum :c:type:`atscmh_rs_frame_ensemble` \{
            \ :ref:`ATSCMH_RSFRAME_ENS_PRI <atscmh-rsframe-ens-pri>`   = 0,
            \ :ref:`ATSCMH_RSFRAME_ENS_SEC <atscmh-rsframe-ens-sec>`   = 1,
    \};

    enum :c:type:`atscmh_rs_frame_mode` \{
            \ :ref:`ATSCMH_RSFRAME_PRI_ONLY <atscmh-rsframe-pri-only>`  = 0,
            \ :ref:`ATSCMH_RSFRAME_PRI_SEC <atscmh-rsframe-pri-sec>`   = 1,
            \ :ref:`ATSCMH_RSFRAME_RES <atscmh-rsframe-res>`       = 2,
    \};

    enum :c:type:`atscmh_rs_code_mode` \{
            \ :ref:`ATSCMH_RSCODE_211_187 <atscmh-rscode-211-187>`    = 0,
            \ :ref:`ATSCMH_RSCODE_223_187 <atscmh-rscode-223-187>`    = 1,
            \ :ref:`ATSCMH_RSCODE_235_187 <atscmh-rscode-235-187>`    = 2,
            \ :ref:`ATSCMH_RSCODE_RES <atscmh-rscode-res>`        = 3,
    \};

    \#define :ref:`NO_STREAM_ID_FILTER <dtv-stream-id>`     (\~0U)
    \#define :ref:`LNA_AUTO <dtv-lna>`                (\~0U)

    struct dtv\_cmds\_h \{
            char    \*name;          \/\* A display name for debugging purposes \*\/

            \_\_u32   cmd;            \/\* A unique ID \*\/

            \/\* Flags \*\/
            \_\_u32   set\:1;          \/\* Either a set or get property \*\/
            \_\_u32   buffer\:1;       \/\* Does this property use the buffer? \*\/
            \_\_u32   reserved\:30;    \/\* Align \*\/
    \};

    \/\*\*
     \* Scale types for the quality parameters.
     \* @:ref:`FE_SCALE_NOT_AVAILABLE <frontend-stat-properties>`\: That QoS measure is not available. That
     \*                          could indicate a temporary or a permanent
     \*                          condition.
     \* @:ref:`FE_SCALE_DECIBEL <frontend-stat-properties>`\: The scale is measured in 0.001 dB steps, typically
     \*                used on signal measures.
     \* @:ref:`FE_SCALE_RELATIVE <frontend-stat-properties>`\: The scale is a relative percentual measure,
     \*                      ranging from 0 (0\%) to 0xffff (100\%).
     \* @:ref:`FE_SCALE_COUNTER <frontend-stat-properties>`\: The scale counts the occurrence of an event, like
     \*                      bit error, block error, lapsed time.
     \*\/
    :ref:`fecap_scale_params <frontend-stat-properties>` \{
            :ref:`FE_SCALE_NOT_AVAILABLE <frontend-stat-properties>` = 0,
            :ref:`FE_SCALE_DECIBEL <frontend-stat-properties>`,
            :ref:`FE_SCALE_RELATIVE <frontend-stat-properties>`,
            :ref:`FE_SCALE_COUNTER <frontend-stat-properties>`
    \};

    \/\*\*
     \* struct :c:type:`dtv_stats` - Used for reading a DTV status property
     \*
     \* @value\:      value of the measure. Should range from 0 to 0xffff;
     \* @scale\:      Filled with :ref:`fecap_scale_params <frontend-stat-properties>` - the scale
     \*              in usage for that parameter
     \*
     \* For most delivery systems, this will return a single value for each
     \* parameter.
     \* It should be noticed, however, that new OFDM delivery systems like
     \* ISDB can use different modulation types for each group of carriers.
     \* On such standards, up to 8 groups of statistics can be provided, one
     \* for each carrier group (called "layer" on ISDB).
     \* In order to be consistent with other delivery systems, the first
     \* value refers to the entire set of carriers ("global").
     \* dtv\_status\:scale should use the value :ref:`FE_SCALE_NOT_AVAILABLE <frontend-stat-properties>` when
     \* the value for the entire group of carriers or from one specific layer
     \* is not provided by the hardware.
     \* st.len should be filled with the latest filled status + 1.
     \*
     \* In other words, for ISDB, those values should be filled like\:
     \*      u.st.stat.svalue[0] = global statistics;
     \*      u.st.stat.scale[0] = :ref:`FE_SCALE_DECIBEL <frontend-stat-properties>`;
     \*      u.st.stat.value[1] = layer A statistics;
     \*      u.st.stat.scale[1] = :ref:`FE_SCALE_NOT_AVAILABLE <frontend-stat-properties>` (if not available);
     \*      u.st.stat.svalue[2] = layer B statistics;
     \*      u.st.stat.scale[2] = :ref:`FE_SCALE_DECIBEL <frontend-stat-properties>`;
     \*      u.st.stat.svalue[3] = layer C statistics;
     \*      u.st.stat.scale[3] = :ref:`FE_SCALE_DECIBEL <frontend-stat-properties>`;
     \*      u.st.len = 4;
     \*\/
    struct :c:type:`dtv_stats` \{
            \_\_u8 scale;     \/\* :ref:`fecap_scale_params <frontend-stat-properties>` type \*\/
            union \{
                    \_\_u64 uvalue;   \/\* for counters and relative scales \*\/
                    \_\_s64 svalue;   \/\* for 0.001 dB measures \*\/
            \};
    \} \_\_attribute\_\_ ((packed));

    \#define MAX\_DTV\_STATS   4

    struct :c:type:`dtv_fe_stats` \{
            \_\_u8 len;
            struct :c:type:`dtv_stats` stat[MAX\_DTV\_STATS];
    \} \_\_attribute\_\_ ((packed));

    struct :c:type:`dtv_property` \{
            \_\_u32 cmd;
            \_\_u32 reserved[3];
            union \{
                    \_\_u32 data;
                    struct :c:type:`dtv_fe_stats` st;
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

    struct :c:type:`dtv_properties` \{
            \_\_u32 num;
            struct :c:type:`dtv_property` \*props;
    \};

    \#if defined(\_\_DVB\_CORE\_\_) \|\| !defined (\_\_KERNEL\_\_)

    \/\*
     \* **DEPRECATED**\: The DVBv3 ioctls, structs and enums should not be used on
     \* newer programs, as it doesn't support the second generation of digital
     \* TV standards, nor supports newer delivery systems.
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

    \/\* This is needed for legacy userspace support \*\/
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

    struct :c:type:`dvb_qpsk_parameters` \{
            \_\_u32           symbol\_rate;  \/\* symbol rate in Symbols per second \*\/
            \ :c:type:`fe_code_rate_t <fe_code_rate>`  fec\_inner;    \/\* forward error correction (see above) \*\/
    \};

    struct :c:type:`dvb_qam_parameters` \{
            \_\_u32           symbol\_rate; \/\* symbol rate in Symbols per second \*\/
            \ :c:type:`fe_code_rate_t <fe_code_rate>`  fec\_inner;   \/\* forward error correction (see above) \*\/
            \ :c:type:`fe_modulation_t <fe_modulation>` modulation;  \/\* modulation type (see above) \*\/
    \};

    struct :c:type:`dvb_vsb_parameters` \{
            \ :c:type:`fe_modulation_t <fe_modulation>` modulation;  \/\* modulation type (see above) \*\/
    \};

    struct :c:type:`dvb_ofdm_parameters` \{
            \ :c:type:`fe_bandwidth_t <fe_bandwidth>`      bandwidth;
            \ :c:type:`fe_code_rate_t <fe_code_rate>`      code\_rate\_HP;  \/\* high priority stream code rate \*\/
            \ :c:type:`fe_code_rate_t <fe_code_rate>`      code\_rate\_LP;  \/\* low priority stream code rate \*\/
            \ :c:type:`fe_modulation_t <fe_modulation>`     constellation; \/\* modulation type (see above) \*\/
            \ :c:type:`fe_transmit_mode_t <fe_transmit_mode>`  transmission\_mode;
            \ :c:type:`fe_guard_interval_t <fe_guard_interval>` guard\_interval;
            \ :c:type:`fe_hierarchy_t <fe_hierarchy>`      hierarchy\_information;
    \};

    struct :c:type:`dvb_frontend_parameters` \{
            \_\_u32 frequency;     \/\* (absolute) frequency in Hz for DVB-C\/DVB-T\/ATSC \*\/
                                 \/\* intermediate frequency in kHz for DVB-S \*\/
            \ :c:type:`fe_spectral_inversion_t <fe_spectral_inversion>` inversion;
            union \{
                    struct :c:type:`dvb_qpsk_parameters` qpsk;        \/\* DVB-S \*\/
                    struct :c:type:`dvb_qam_parameters`  qam;         \/\* DVB-C \*\/
                    struct :c:type:`dvb_ofdm_parameters` ofdm;        \/\* DVB-T \*\/
                    struct :c:type:`dvb_vsb_parameters` vsb;          \/\* ATSC \*\/
            \} u;
    \};

    struct :c:type:`dvb_frontend_event` \{
            \ :c:type:`fe_status_t <fe_status>` status;
            struct :c:type:`dvb_frontend_parameters` parameters;
    \};
    \#endif

    \#define :c:type:`FE_SET_PROPERTY <FE_GET_PROPERTY>`            \_IOW('o', 82, struct :c:type:`dtv_properties`\ )
    \#define \ :ref:`FE_GET_PROPERTY <fe_get_property>`            \_IOR('o', 83, struct :c:type:`dtv_properties`\ )

    \/\*\*
     \* When set, this flag will disable any zigzagging or other "normal" tuning
     \* behaviour. Additionally, there will be no automatic monitoring of the lock
     \* status, and hence no frontend events will be generated. If a frontend device
     \* is closed, this flag will be automatically turned off when the device is
     \* reopened read-write.
     \*\/
    \#define :c:func:`FE_TUNE_MODE_ONESHOT <FE_SET_FRONTEND_TUNE_MODE>` 0x01

    \#define \ :ref:`FE_GET_INFO <fe_get_info>`                \_IOR('o', 61, struct :c:type:`dvb_frontend_info`\ )

    \#define \ :ref:`FE_DISEQC_RESET_OVERLOAD <fe_diseqc_reset_overload>`   \_IO('o', 62)
    \#define \ :ref:`FE_DISEQC_SEND_MASTER_CMD <fe_diseqc_send_master_cmd>`  \_IOW('o', 63, struct :c:type:`dvb_diseqc_master_cmd`\ )
    \#define \ :ref:`FE_DISEQC_RECV_SLAVE_REPLY <fe_diseqc_recv_slave_reply>` \_IOR('o', 64, struct :c:type:`dvb_diseqc_slave_reply`\ )
    \#define \ :ref:`FE_DISEQC_SEND_BURST <fe_diseqc_send_burst>`       \_IO('o', 65)  \/\* \ :c:type:`fe_sec_mini_cmd_t <fe_sec_mini_cmd>` \*\/

    \#define \ :ref:`FE_SET_TONE <fe_set_tone>`                \_IO('o', 66)  \/\* \ :c:type:`fe_sec_tone_mode_t <fe_sec_tone_mode>` \*\/
    \#define \ :ref:`FE_SET_VOLTAGE <fe_set_voltage>`             \_IO('o', 67)  \/\* :c:type:`fe_sec_voltage_t <fe_sec_voltage>` \*\/
    \#define \ :ref:`FE_ENABLE_HIGH_LNB_VOLTAGE <fe_enable_high_lnb_voltage>` \_IO('o', 68)  \/\* int \*\/

    \#define \ :ref:`FE_READ_STATUS <fe_read_status>`             \_IOR('o', 69, \ :c:type:`fe_status_t <fe_status>`\ )
    \#define \ :ref:`FE_READ_BER <fe_read_ber>`                \_IOR('o', 70, \_\_u32)
    \#define \ :ref:`FE_READ_SIGNAL_STRENGTH <fe_read_signal_strength>`    \_IOR('o', 71, \_\_u16)
    \#define \ :ref:`FE_READ_SNR <fe_read_snr>`                \_IOR('o', 72, \_\_u16)
    \#define \ :ref:`FE_READ_UNCORRECTED_BLOCKS <fe_read_uncorrected_blocks>` \_IOR('o', 73, \_\_u32)

    \#define \ :ref:`FE_SET_FRONTEND <fe_set_frontend>`            \_IOW('o', 76, struct :c:type:`dvb_frontend_parameters`\ )
    \#define \ :ref:`FE_GET_FRONTEND <fe_get_frontend>`            \_IOR('o', 77, struct :c:type:`dvb_frontend_parameters`\ )
    \#define \ :ref:`FE_SET_FRONTEND_TUNE_MODE <fe_set_frontend_tune_mode>`  \_IO('o', 81) \/\* unsigned int \*\/
    \#define \ :ref:`FE_GET_EVENT <fe_get_event>`               \_IOR('o', 78, struct :c:type:`dvb_frontend_event`\ )

    \#define \ :ref:`FE_DISHNETWORK_SEND_LEGACY_CMD <fe_dishnetwork_send_legacy_cmd>` \_IO('o', 80) \/\* unsigned int \*\/

    \#endif \/\*\_DVBFRONTEND\_H\_\*\/
