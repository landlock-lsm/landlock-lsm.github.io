.. -*- coding: utf-8; mode: rst -*-

cec.h
=====

.. parsed-literal::

    \/\* SPDX-License-Identifier\: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) \*\/
    \/\*
     \* cec - HDMI Consumer Electronics Control public header
     \*
     \* Copyright 2016 Cisco Systems, Inc. and\/or its affiliates. All rights reserved.
     \*\/

    \#ifndef \_CEC\_UAPI\_H
    \#define \_CEC\_UAPI\_H

    \#include \<linux\/types.h\>
    \#include \<linux\/string.h\>

    \#define CEC\_MAX\_MSG\_SIZE        16

    \/\*\*
     \* struct cec_msg - CEC message structure.
     \* @tx\_ts\:      Timestamp in nanoseconds using CLOCK\_MONOTONIC. Set by the
     \*              driver when the message transmission has finished.
     \* @rx\_ts\:      Timestamp in nanoseconds using CLOCK\_MONOTONIC. Set by the
     \*              driver when the message was received.
     \* @len\:        Length in bytes of the message.
     \* @timeout\:    The timeout (in ms) that is used to timeout CEC\_RECEIVE.
     \*              Set to 0 if you want to wait forever. This timeout can also be
     \*              used with \ :ref:`CEC_TRANSMIT <cec_transmit>` as the timeout for waiting for a reply.
     \*              If 0, then it will use a 1 second timeout instead of waiting
     \*              forever as is done with CEC\_RECEIVE.
     \* @sequence\:   The framework assigns a sequence number to messages that are
     \*              sent. This can be used to track replies to previously sent
     \*              messages.
     \* @flags\:      Set to 0.
     \* @msg\:        The message payload.
     \* @reply\:      This field is ignored with \ :ref:`CEC_RECEIVE <cec_receive>` and is only used by
     \*              CEC\_TRANSMIT. If non-zero, then wait for a reply with this
     \*              opcode. Set to CEC\_MSG\_FEATURE\_ABORT if you want to wait for
     \*              a possible ABORT reply. If there was an error when sending the
     \*              msg or FeatureAbort was returned, then reply is set to 0.
     \*              If reply is non-zero upon return, then len\/msg are set to
     \*              the received message.
     \*              If reply is zero upon return and status has the
     \*              CEC\_TX\_STATUS\_FEATURE\_ABORT bit set, then len\/msg are set to
     \*              the received feature abort message.
     \*              If reply is zero upon return and status has the
     \*              \ :ref:`CEC_TX_STATUS_MAX_RETRIES <cec-tx-status-max-retries>` bit set, then no reply was seen at
     \*              all. If reply is non-zero for \ :ref:`CEC_TRANSMIT <cec_transmit>` and the message is a
     \*              broadcast, then -EINVAL is returned.
     \*              if reply is non-zero, then timeout is set to 1000 (the required
     \*              maximum response time).
     \* @rx\_status\:  The message receive status bits. Set by the driver.
     \* @tx\_status\:  The message transmit status bits. Set by the driver.
     \* @tx\_arb\_lost\_cnt\: The number of 'Arbitration Lost' events. Set by the driver.
     \* @tx\_nack\_cnt\: The number of 'Not Acknowledged' events. Set by the driver.
     \* @tx\_low\_drive\_cnt\: The number of 'Low Drive Detected' events. Set by the
     \*              driver.
     \* @tx\_error\_cnt\: The number of 'Error' events. Set by the driver.
     \*\/
    struct cec_msg \{
            \_\_u64 tx\_ts;
            \_\_u64 rx\_ts;
            \_\_u32 len;
            \_\_u32 timeout;
            \_\_u32 sequence;
            \_\_u32 flags;
            \_\_u8 msg[CEC\_MAX\_MSG\_SIZE];
            \_\_u8 reply;
            \_\_u8 rx\_status;
            \_\_u8 tx\_status;
            \_\_u8 tx\_arb\_lost\_cnt;
            \_\_u8 tx\_nack\_cnt;
            \_\_u8 tx\_low\_drive\_cnt;
            \_\_u8 tx\_error\_cnt;
    \};

    \/\*\*
     \* cec\_msg\_initiator - return the initiator's logical address.
     \* @msg\:        the message structure
     \*\/
    static inline \_\_u8 cec\_msg\_initiator(const struct cec_msg \*msg)
    \{
            return msg-\>msg[0] \>\> 4;
    \}

    \/\*\*
     \* cec\_msg\_destination - return the destination's logical address.
     \* @msg\:        the message structure
     \*\/
    static inline \_\_u8 cec\_msg\_destination(const struct cec_msg \*msg)
    \{
            return msg-\>msg[0] \& 0xf;
    \}

    \/\*\*
     \* cec\_msg\_opcode - return the opcode of the message, -1 for poll
     \* @msg\:        the message structure
     \*\/
    static inline int cec\_msg\_opcode(const struct cec_msg \*msg)
    \{
            return msg-\>len \> 1 ? msg-\>msg[1] \: -1;
    \}

    \/\*\*
     \* cec\_msg\_is\_broadcast - return true if this is a broadcast message.
     \* @msg\:        the message structure
     \*\/
    static inline int cec\_msg\_is\_broadcast(const struct cec_msg \*msg)
    \{
            return (msg-\>msg[0] \& 0xf) == 0xf;
    \}

    \/\*\*
     \* cec\_msg\_init - initialize the message structure.
     \* @msg\:        the message structure
     \* @initiator\:  the logical address of the initiator
     \* @destination\:the logical address of the destination (0xf for broadcast)
     \*
     \* The whole structure is zeroed, the len field is set to 1 (i.e. a poll
     \* message) and the initiator and destination are filled in.
     \*\/
    static inline void cec\_msg\_init(struct cec_msg \*msg,
                                    \_\_u8 initiator, \_\_u8 destination)
    \{
            memset(msg, 0, sizeof(\*msg));
            msg-\>msg[0] = (initiator \<\< 4) \| destination;
            msg-\>len = 1;
    \}

    \/\*\*
     \* cec\_msg\_set\_reply\_to - fill in destination\/initiator in a reply message.
     \* @msg\:        the message structure for the reply
     \* @orig\:       the original message structure
     \*
     \* Set the msg destination to the orig initiator and the msg initiator to the
     \* orig destination. Note that msg and orig may be the same pointer, in which
     \* case the change is done in place.
     \*\/
    static inline void cec\_msg\_set\_reply\_to(struct cec_msg \*msg,
                                            struct cec_msg \*orig)
    \{
            \/\* The destination becomes the initiator and vice versa \*\/
            msg-\>msg[0] = (cec\_msg\_destination(orig) \<\< 4) \|
                          cec\_msg\_initiator(orig);
            msg-\>reply = msg-\>timeout = 0;
    \}

    \/\* cec\_msg flags field \*\/
    \#define \ :ref:`CEC_MSG_FL_REPLY_TO_FOLLOWERS <cec-msg-fl-reply-to-followers>`   (1 \<\< 0)
    \#define \ :ref:`CEC_MSG_FL_RAW <cec-msg-fl-raw>`                  (1 \<\< 1)

    \/\* cec\_msg tx\/rx\_status field \*\/
    \#define \ :ref:`CEC_TX_STATUS_OK <cec-tx-status-ok>`                (1 \<\< 0)
    \#define \ :ref:`CEC_TX_STATUS_ARB_LOST <cec-tx-status-arb-lost>`          (1 \<\< 1)
    \#define \ :ref:`CEC_TX_STATUS_NACK <cec-tx-status-nack>`              (1 \<\< 2)
    \#define \ :ref:`CEC_TX_STATUS_LOW_DRIVE <cec-tx-status-low-drive>`         (1 \<\< 3)
    \#define \ :ref:`CEC_TX_STATUS_ERROR <cec-tx-status-error>`             (1 \<\< 4)
    \#define \ :ref:`CEC_TX_STATUS_MAX_RETRIES <cec-tx-status-max-retries>`       (1 \<\< 5)
    \#define \ :ref:`CEC_TX_STATUS_ABORTED <cec-tx-status-aborted>`           (1 \<\< 6)
    \#define \ :ref:`CEC_TX_STATUS_TIMEOUT <cec-tx-status-timeout>`           (1 \<\< 7)

    \#define \ :ref:`CEC_RX_STATUS_OK <cec-rx-status-ok>`                (1 \<\< 0)
    \#define \ :ref:`CEC_RX_STATUS_TIMEOUT <cec-rx-status-timeout>`           (1 \<\< 1)
    \#define \ :ref:`CEC_RX_STATUS_FEATURE_ABORT <cec-rx-status-feature-abort>`     (1 \<\< 2)
    \#define \ :ref:`CEC_RX_STATUS_ABORTED <cec-rx-status-aborted>`           (1 \<\< 3)

    static inline int cec\_msg\_status\_is\_ok(const struct cec_msg \*msg)
    \{
            if (msg-\>tx\_status \&\& !(msg-\>tx\_status \& \ :ref:`CEC_TX_STATUS_OK <cec-tx-status-ok>`\ ))
                    return 0;
            if (msg-\>rx\_status \&\& !(msg-\>rx\_status \& \ :ref:`CEC_RX_STATUS_OK <cec-rx-status-ok>`\ ))
                    return 0;
            if (!msg-\>tx\_status \&\& !msg-\>rx\_status)
                    return 0;
            return !(msg-\>rx\_status \& \ :ref:`CEC_RX_STATUS_FEATURE_ABORT <cec-rx-status-feature-abort>`\ );
    \}

    \#define CEC\_LOG\_ADDR\_INVALID            0xff
    \#define CEC\_PHYS\_ADDR\_INVALID           0xffff

    \/\*
     \* The maximum number of logical addresses one device can be assigned to.
     \* The CEC 2.0 spec allows for only 2 logical addresses at the moment. The
     \* Analog Devices CEC hardware supports 3. So let's go wild and go for 4.
     \*\/
    \#define CEC\_MAX\_LOG\_ADDRS 4

    \/\* The logical addresses defined by CEC 2.0 \*\/
    \#define CEC\_LOG\_ADDR\_TV                 0
    \#define CEC\_LOG\_ADDR\_RECORD\_1           1
    \#define CEC\_LOG\_ADDR\_RECORD\_2           2
    \#define CEC\_LOG\_ADDR\_TUNER\_1            3
    \#define CEC\_LOG\_ADDR\_PLAYBACK\_1         4
    \#define CEC\_LOG\_ADDR\_AUDIOSYSTEM        5
    \#define CEC\_LOG\_ADDR\_TUNER\_2            6
    \#define CEC\_LOG\_ADDR\_TUNER\_3            7
    \#define CEC\_LOG\_ADDR\_PLAYBACK\_2         8
    \#define CEC\_LOG\_ADDR\_RECORD\_3           9
    \#define CEC\_LOG\_ADDR\_TUNER\_4            10
    \#define CEC\_LOG\_ADDR\_PLAYBACK\_3         11
    \#define CEC\_LOG\_ADDR\_BACKUP\_1           12
    \#define CEC\_LOG\_ADDR\_BACKUP\_2           13
    \#define CEC\_LOG\_ADDR\_SPECIFIC           14
    \#define CEC\_LOG\_ADDR\_UNREGISTERED       15 \/\* as initiator address \*\/
    \#define CEC\_LOG\_ADDR\_BROADCAST          15 \/\* as destination address \*\/

    \/\* The logical address types that the CEC device wants to claim \*\/
    \#define \ :ref:`CEC_LOG_ADDR_TYPE_TV <cec-log-addr-type-tv>`            0
    \#define \ :ref:`CEC_LOG_ADDR_TYPE_RECORD <cec-log-addr-type-record>`        1
    \#define \ :ref:`CEC_LOG_ADDR_TYPE_TUNER <cec-log-addr-type-tuner>`         2
    \#define \ :ref:`CEC_LOG_ADDR_TYPE_PLAYBACK <cec-log-addr-type-playback>`      3
    \#define \ :ref:`CEC_LOG_ADDR_TYPE_AUDIOSYSTEM <cec-log-addr-type-audiosystem>`   4
    \#define \ :ref:`CEC_LOG_ADDR_TYPE_SPECIFIC <cec-log-addr-type-specific>`      5
    \#define \ :ref:`CEC_LOG_ADDR_TYPE_UNREGISTERED <cec-log-addr-type-unregistered>`  6
    \/\*
     \* Switches should use UNREGISTERED.
     \* Processors should use SPECIFIC.
     \*\/

    \#define CEC\_LOG\_ADDR\_MASK\_TV            (1 \<\< CEC\_LOG\_ADDR\_TV)
    \#define CEC\_LOG\_ADDR\_MASK\_RECORD        ((1 \<\< CEC\_LOG\_ADDR\_RECORD\_1) \| \\
                                             (1 \<\< CEC\_LOG\_ADDR\_RECORD\_2) \| \\
                                             (1 \<\< CEC\_LOG\_ADDR\_RECORD\_3))
    \#define CEC\_LOG\_ADDR\_MASK\_TUNER         ((1 \<\< CEC\_LOG\_ADDR\_TUNER\_1) \| \\
                                             (1 \<\< CEC\_LOG\_ADDR\_TUNER\_2) \| \\
                                             (1 \<\< CEC\_LOG\_ADDR\_TUNER\_3) \| \\
                                             (1 \<\< CEC\_LOG\_ADDR\_TUNER\_4))
    \#define CEC\_LOG\_ADDR\_MASK\_PLAYBACK      ((1 \<\< CEC\_LOG\_ADDR\_PLAYBACK\_1) \| \\
                                             (1 \<\< CEC\_LOG\_ADDR\_PLAYBACK\_2) \| \\
                                             (1 \<\< CEC\_LOG\_ADDR\_PLAYBACK\_3))
    \#define CEC\_LOG\_ADDR\_MASK\_AUDIOSYSTEM   (1 \<\< CEC\_LOG\_ADDR\_AUDIOSYSTEM)
    \#define CEC\_LOG\_ADDR\_MASK\_BACKUP        ((1 \<\< CEC\_LOG\_ADDR\_BACKUP\_1) \| \\
                                             (1 \<\< CEC\_LOG\_ADDR\_BACKUP\_2))
    \#define CEC\_LOG\_ADDR\_MASK\_SPECIFIC      (1 \<\< CEC\_LOG\_ADDR\_SPECIFIC)
    \#define CEC\_LOG\_ADDR\_MASK\_UNREGISTERED  (1 \<\< CEC\_LOG\_ADDR\_UNREGISTERED)

    static inline int cec\_has\_tv(\_\_u16 log\_addr\_mask)
    \{
            return log\_addr\_mask \& CEC\_LOG\_ADDR\_MASK\_TV;
    \}

    static inline int cec\_has\_record(\_\_u16 log\_addr\_mask)
    \{
            return log\_addr\_mask \& CEC\_LOG\_ADDR\_MASK\_RECORD;
    \}

    static inline int cec\_has\_tuner(\_\_u16 log\_addr\_mask)
    \{
            return log\_addr\_mask \& CEC\_LOG\_ADDR\_MASK\_TUNER;
    \}

    static inline int cec\_has\_playback(\_\_u16 log\_addr\_mask)
    \{
            return log\_addr\_mask \& CEC\_LOG\_ADDR\_MASK\_PLAYBACK;
    \}

    static inline int cec\_has\_audiosystem(\_\_u16 log\_addr\_mask)
    \{
            return log\_addr\_mask \& CEC\_LOG\_ADDR\_MASK\_AUDIOSYSTEM;
    \}

    static inline int cec\_has\_backup(\_\_u16 log\_addr\_mask)
    \{
            return log\_addr\_mask \& CEC\_LOG\_ADDR\_MASK\_BACKUP;
    \}

    static inline int cec\_has\_specific(\_\_u16 log\_addr\_mask)
    \{
            return log\_addr\_mask \& CEC\_LOG\_ADDR\_MASK\_SPECIFIC;
    \}

    static inline int cec\_is\_unregistered(\_\_u16 log\_addr\_mask)
    \{
            return log\_addr\_mask \& CEC\_LOG\_ADDR\_MASK\_UNREGISTERED;
    \}

    static inline int cec\_is\_unconfigured(\_\_u16 log\_addr\_mask)
    \{
            return log\_addr\_mask == 0;
    \}

    \/\*
     \* Use this if there is no vendor ID (CEC\_G\_VENDOR\_ID) or if the vendor ID
     \* should be disabled (CEC\_S\_VENDOR\_ID)
     \*\/
    \#define CEC\_VENDOR\_ID\_NONE              0xffffffff

    \/\* The message handling modes \*\/
    \/\* Modes for initiator \*\/
    \#define \ :ref:`CEC_MODE_NO_INITIATOR <cec-mode-no-initiator>`           (0x0 \<\< 0)
    \#define \ :ref:`CEC_MODE_INITIATOR <cec-mode-initiator>`              (0x1 \<\< 0)
    \#define \ :ref:`CEC_MODE_EXCL_INITIATOR <cec-mode-excl-initiator>`         (0x2 \<\< 0)
    \#define CEC\_MODE\_INITIATOR\_MSK          0x0f

    \/\* Modes for follower \*\/
    \#define \ :ref:`CEC_MODE_NO_FOLLOWER <cec-mode-no-follower>`            (0x0 \<\< 4)
    \#define \ :ref:`CEC_MODE_FOLLOWER <cec-mode-follower>`               (0x1 \<\< 4)
    \#define \ :ref:`CEC_MODE_EXCL_FOLLOWER <cec-mode-excl-follower>`          (0x2 \<\< 4)
    \#define \ :ref:`CEC_MODE_EXCL_FOLLOWER_PASSTHRU <cec-mode-excl-follower-passthru>` (0x3 \<\< 4)
    \#define \ :ref:`CEC_MODE_MONITOR_PIN <cec-mode-monitor-pin>`            (0xd \<\< 4)
    \#define \ :ref:`CEC_MODE_MONITOR <cec-mode-monitor>`                (0xe \<\< 4)
    \#define \ :ref:`CEC_MODE_MONITOR_ALL <cec-mode-monitor-all>`            (0xf \<\< 4)
    \#define CEC\_MODE\_FOLLOWER\_MSK           0xf0

    \/\* Userspace has to configure the physical address \*\/
    \#define \ :ref:`CEC_CAP_PHYS_ADDR <cec-cap-phys-addr>`       (1 \<\< 0)
    \/\* Userspace has to configure the logical addresses \*\/
    \#define \ :ref:`CEC_CAP_LOG_ADDRS <cec-cap-log-addrs>`       (1 \<\< 1)
    \/\* Userspace can transmit messages (and thus become follower as well) \*\/
    \#define \ :ref:`CEC_CAP_TRANSMIT <cec-cap-transmit>`        (1 \<\< 2)
    \/\*
     \* Passthrough all messages instead of processing them.
     \*\/
    \#define \ :ref:`CEC_CAP_PASSTHROUGH <cec-cap-passthrough>`     (1 \<\< 3)
    \/\* Supports remote control \*\/
    \#define \ :ref:`CEC_CAP_RC <cec-cap-rc>`              (1 \<\< 4)
    \/\* Hardware can monitor all messages, not just directed and broadcast. \*\/
    \#define \ :ref:`CEC_CAP_MONITOR_ALL <cec-cap-monitor-all>`     (1 \<\< 5)
    \/\* Hardware can use CEC only if the HDMI HPD pin is high. \*\/
    \#define \ :ref:`CEC_CAP_NEEDS_HPD <cec-cap-needs-hpd>`       (1 \<\< 6)
    \/\* Hardware can monitor CEC pin transitions \*\/
    \#define \ :ref:`CEC_CAP_MONITOR_PIN <cec-cap-monitor-pin>`     (1 \<\< 7)
    \/\* \ :ref:`CEC_ADAP_G_CONNECTOR_INFO <cec_adap_g_connector_info>` is available \*\/
    \#define \ :ref:`CEC_CAP_CONNECTOR_INFO <cec-cap-connector-info>`  (1 \<\< 8)

    \/\*\*
     \* struct cec_caps - CEC capabilities structure.
     \* @driver\: name of the CEC device driver.
     \* @name\: name of the CEC device. @driver + @name must be unique.
     \* @available\_log\_addrs\: number of available logical addresses.
     \* @capabilities\: capabilities of the CEC adapter.
     \* @version\: version of the CEC adapter framework.
     \*\/
    struct cec_caps \{
            char driver[32];
            char name[32];
            \_\_u32 available\_log\_addrs;
            \_\_u32 capabilities;
            \_\_u32 version;
    \};

    \/\*\*
     \* struct cec_log_addrs - CEC logical addresses structure.
     \* @log\_addr\: the claimed logical addresses. Set by the driver.
     \* @log\_addr\_mask\: current logical address mask. Set by the driver.
     \* @cec\_version\: the CEC version that the adapter should implement. Set by the
     \*      caller.
     \* @num\_log\_addrs\: how many logical addresses should be claimed. Set by the
     \*      caller.
     \* @vendor\_id\: the vendor ID of the device. Set by the caller.
     \* @flags\: flags.
     \* @osd\_name\: the OSD name of the device. Set by the caller.
     \* @primary\_device\_type\: the primary device type for each logical address.
     \*      Set by the caller.
     \* @log\_addr\_type\: the logical address types. Set by the caller.
     \* @all\_device\_types\: CEC 2.0\: all device types represented by the logical
     \*      address. Set by the caller.
     \* @features\:   CEC 2.0\: The logical address features. Set by the caller.
     \*\/
    struct cec_log_addrs \{
            \_\_u8 log\_addr[CEC\_MAX\_LOG\_ADDRS];
            \_\_u16 log\_addr\_mask;
            \_\_u8 cec\_version;
            \_\_u8 num\_log\_addrs;
            \_\_u32 vendor\_id;
            \_\_u32 flags;
            char osd\_name[15];
            \_\_u8 primary\_device\_type[CEC\_MAX\_LOG\_ADDRS];
            \_\_u8 log\_addr\_type[CEC\_MAX\_LOG\_ADDRS];

            \/\* CEC 2.0 \*\/
            \_\_u8 all\_device\_types[CEC\_MAX\_LOG\_ADDRS];
            \_\_u8 features[CEC\_MAX\_LOG\_ADDRS][12];
    \};

    \/\* Allow a fallback to unregistered \*\/
    \#define \ :ref:`CEC_LOG_ADDRS_FL_ALLOW_UNREG_FALLBACK <cec-log-addrs-fl-allow-unreg-fallback>`   (1 \<\< 0)
    \/\* Passthrough RC messages to the input subsystem \*\/
    \#define \ :ref:`CEC_LOG_ADDRS_FL_ALLOW_RC_PASSTHRU <cec-log-addrs-fl-allow-rc-passthru>`      (1 \<\< 1)
    \/\* CDC-Only device\: supports only CDC messages \*\/
    \#define \ :ref:`CEC_LOG_ADDRS_FL_CDC_ONLY <cec-log-addrs-fl-cdc-only>`               (1 \<\< 2)

    \/\*\*
     \* struct cec_drm_connector_info - tells which drm connector is
     \* associated with the CEC adapter.
     \* @card\_no\: drm card number
     \* @connector\_id\: drm connector ID
     \*\/
    struct cec_drm_connector_info \{
            \_\_u32 card\_no;
            \_\_u32 connector\_id;
    \};

    \#define \ :ref:`CEC_CONNECTOR_TYPE_NO_CONNECTOR <cec-connector-type-no-connector>` 0
    \#define \ :ref:`CEC_CONNECTOR_TYPE_DRM <cec-connector-type-drm>`          1

    \/\*\*
     \* struct cec_connector_info - tells if and which connector is
     \* associated with the CEC adapter.
     \* @type\: connector type (if any)
     \* @drm\: drm connector info
     \*\/
    struct cec_connector_info \{
            \_\_u32 type;
            union \{
                    struct cec_drm_connector_info drm;
                    \_\_u32 raw[16];
            \};
    \};

    \/\* Events \*\/

    \/\* Event that occurs when the adapter state changes \*\/
    \#define \ :ref:`CEC_EVENT_STATE_CHANGE <cec-event-state-change>`          1
    \/\*
     \* This event is sent when messages are lost because the application
     \* didn't empty the message queue in time
     \*\/
    \#define \ :ref:`CEC_EVENT_LOST_MSGS <cec-event-lost-msgs>`             2
    \#define \ :ref:`CEC_EVENT_PIN_CEC_LOW <cec-event-pin-cec-low>`           3
    \#define \ :ref:`CEC_EVENT_PIN_CEC_HIGH <cec-event-pin-cec-high>`          4
    \#define \ :ref:`CEC_EVENT_PIN_HPD_LOW <cec-event-pin-hpd-low>`           5
    \#define \ :ref:`CEC_EVENT_PIN_HPD_HIGH <cec-event-pin-hpd-high>`          6
    \#define \ :ref:`CEC_EVENT_PIN_5V_LOW <cec-event-pin-5v-low>`            7
    \#define \ :ref:`CEC_EVENT_PIN_5V_HIGH <cec-event-pin-5v-high>`           8

    \#define \ :ref:`CEC_EVENT_FL_INITIAL_STATE <cec-event-fl-initial-state>`      (1 \<\< 0)
    \#define \ :ref:`CEC_EVENT_FL_DROPPED_EVENTS <cec-event-fl-dropped-events>`     (1 \<\< 1)

    \/\*\*
     \* struct cec_event_state_change - used when the CEC adapter changes state.
     \* @phys\_addr\: the current physical address
     \* @log\_addr\_mask\: the current logical address mask
     \* @have\_conn\_info\: if non-zero, then HDMI connector information is available.
     \*      This field is only valid if \ :ref:`CEC_CAP_CONNECTOR_INFO <cec-cap-connector-info>` is set. If that
     \*      capability is set and @have\_conn\_info is zero, then that indicates
     \*      that the HDMI connector device is not instantiated, either because
     \*      the HDMI driver is still configuring the device or because the HDMI
     \*      device was unbound.
     \*\/
    struct cec_event_state_change \{
            \_\_u16 phys\_addr;
            \_\_u16 log\_addr\_mask;
            \_\_u16 have\_conn\_info;
    \};

    \/\*\*
     \* struct cec_event_lost_msgs - tells you how many messages were lost.
     \* @lost\_msgs\: how many messages were lost.
     \*\/
    struct cec_event_lost_msgs \{
            \_\_u32 lost\_msgs;
    \};

    \/\*\*
     \* struct cec_event - CEC event structure
     \* @ts\: the timestamp of when the event was sent.
     \* @event\: the event.
     \* array.
     \* @state\_change\: the event payload for CEC\_EVENT\_STATE\_CHANGE.
     \* @lost\_msgs\: the event payload for CEC\_EVENT\_LOST\_MSGS.
     \* @raw\: array to pad the union.
     \*\/
    struct cec_event \{
            \_\_u64 ts;
            \_\_u32 event;
            \_\_u32 flags;
            union \{
                    struct cec_event_state_change state\_change;
                    struct cec_event_lost_msgs lost\_msgs;
                    \_\_u32 raw[16];
            \};
    \};

    \/\* ioctls \*\/

    \/\* Adapter capabilities \*\/
    \#define \ :ref:`CEC_ADAP_G_CAPS <cec_adap_g_caps>`         \_IOWR('a',  0, struct cec_caps\ )

    \/\*
     \* phys\_addr is either 0 (if this is the CEC root device)
     \* or a valid physical address obtained from the sink's EDID
     \* as read by this CEC device (if this is a source device)
     \* or a physical address obtained and modified from a sink
     \* EDID and used for a sink CEC device.
     \* If nothing is connected, then phys\_addr is 0xffff.
     \* See HDMI 1.4b, section 8.7 (Physical Address).
     \*
     \* The \ :ref:`CEC_ADAP_S_PHYS_ADDR <cec_adap_s_phys_addr>` ioctl may not be available if that is handled
     \* internally.
     \*\/
    \#define \ :ref:`CEC_ADAP_G_PHYS_ADDR <cec_adap_g_phys_addr>`    \_IOR('a',  1, \_\_u16)
    \#define \ :ref:`CEC_ADAP_S_PHYS_ADDR <cec_adap_s_phys_addr>`    \_IOW('a',  2, \_\_u16)

    \/\*
     \* Configure the CEC adapter. It sets the device type and which
     \* logical types it will try to claim. It will return which
     \* logical addresses it could actually claim.
     \* An error is returned if the adapter is disabled or if there
     \* is no physical address assigned.
     \*\/

    \#define \ :ref:`CEC_ADAP_G_LOG_ADDRS <cec_adap_g_log_addrs>`    \_IOR('a',  3, struct cec_log_addrs\ )
    \#define \ :ref:`CEC_ADAP_S_LOG_ADDRS <cec_adap_s_log_addrs>`    \_IOWR('a',  4, struct cec_log_addrs\ )

    \/\* Transmit\/receive a CEC command \*\/
    \#define \ :ref:`CEC_TRANSMIT <cec_transmit>`            \_IOWR('a',  5, struct cec_msg\ )
    \#define \ :ref:`CEC_RECEIVE <cec_receive>`             \_IOWR('a',  6, struct cec_msg\ )

    \/\* Dequeue CEC events \*\/
    \#define \ :ref:`CEC_DQEVENT <cec_dqevent>`             \_IOWR('a',  7, struct cec_event\ )

    \/\*
     \* Get and set the message handling mode for this filehandle.
     \*\/
    \#define \ :ref:`CEC_G_MODE <cec_g_mode>`              \_IOR('a',  8, \_\_u32)
    \#define \ :ref:`CEC_S_MODE <cec_s_mode>`              \_IOW('a',  9, \_\_u32)

    \/\* Get the connector info \*\/
    \#define \ :ref:`CEC_ADAP_G_CONNECTOR_INFO <cec_adap_g_connector_info>` \_IOR('a',  10, struct cec_connector_info\ )

    \/\*
     \* The remainder of this header defines all CEC messages and operands.
     \* The format matters since it the cec-ctl utility parses it to generate
     \* code for implementing all these messages.
     \*
     \* Comments ending with 'Feature' group messages for each feature.
     \* If messages are part of multiple features, then the "Has also"
     \* comment is used to list the previously defined messages that are
     \* supported by the feature.
     \*
     \* Before operands are defined a comment is added that gives the
     \* name of the operand and in brackets the variable name of the
     \* corresponding argument in the cec-funcs.h function.
     \*\/

    \/\* Messages \*\/

    \/\* One Touch Play Feature \*\/
    \#define CEC\_MSG\_ACTIVE\_SOURCE                           0x82
    \#define CEC\_MSG\_IMAGE\_VIEW\_ON                           0x04
    \#define CEC\_MSG\_TEXT\_VIEW\_ON                            0x0d

    \/\* Routing Control Feature \*\/

    \/\*
     \* Has also\:
     \*      CEC\_MSG\_ACTIVE\_SOURCE
     \*\/

    \#define CEC\_MSG\_INACTIVE\_SOURCE                         0x9d
    \#define CEC\_MSG\_REQUEST\_ACTIVE\_SOURCE                   0x85
    \#define CEC\_MSG\_ROUTING\_CHANGE                          0x80
    \#define CEC\_MSG\_ROUTING\_INFORMATION                     0x81
    \#define CEC\_MSG\_SET\_STREAM\_PATH                         0x86

    \/\* Standby Feature \*\/
    \#define CEC\_MSG\_STANDBY                                 0x36

    \/\* One Touch Record Feature \*\/
    \#define CEC\_MSG\_RECORD\_OFF                              0x0b
    \#define CEC\_MSG\_RECORD\_ON                               0x09
    \/\* Record Source Type Operand (rec\_src\_type) \*\/
    \#define CEC\_OP\_RECORD\_SRC\_OWN                           1
    \#define CEC\_OP\_RECORD\_SRC\_DIGITAL                       2
    \#define CEC\_OP\_RECORD\_SRC\_ANALOG                        3
    \#define CEC\_OP\_RECORD\_SRC\_EXT\_PLUG                      4
    \#define CEC\_OP\_RECORD\_SRC\_EXT\_PHYS\_ADDR                 5
    \/\* Service Identification Method Operand (service\_id\_method) \*\/
    \#define CEC\_OP\_SERVICE\_ID\_METHOD\_BY\_DIG\_ID              0
    \#define CEC\_OP\_SERVICE\_ID\_METHOD\_BY\_CHANNEL             1
    \/\* Digital Service Broadcast System Operand (dig\_bcast\_system) \*\/
    \#define CEC\_OP\_DIG\_SERVICE\_BCAST\_SYSTEM\_ARIB\_GEN        0x00
    \#define CEC\_OP\_DIG\_SERVICE\_BCAST\_SYSTEM\_ATSC\_GEN        0x01
    \#define CEC\_OP\_DIG\_SERVICE\_BCAST\_SYSTEM\_DVB\_GEN         0x02
    \#define CEC\_OP\_DIG\_SERVICE\_BCAST\_SYSTEM\_ARIB\_BS         0x08
    \#define CEC\_OP\_DIG\_SERVICE\_BCAST\_SYSTEM\_ARIB\_CS         0x09
    \#define CEC\_OP\_DIG\_SERVICE\_BCAST\_SYSTEM\_ARIB\_T          0x0a
    \#define CEC\_OP\_DIG\_SERVICE\_BCAST\_SYSTEM\_ATSC\_CABLE      0x10
    \#define CEC\_OP\_DIG\_SERVICE\_BCAST\_SYSTEM\_ATSC\_SAT        0x11
    \#define CEC\_OP\_DIG\_SERVICE\_BCAST\_SYSTEM\_ATSC\_T          0x12
    \#define CEC\_OP\_DIG\_SERVICE\_BCAST\_SYSTEM\_DVB\_C           0x18
    \#define CEC\_OP\_DIG\_SERVICE\_BCAST\_SYSTEM\_DVB\_S           0x19
    \#define CEC\_OP\_DIG\_SERVICE\_BCAST\_SYSTEM\_DVB\_S2          0x1a
    \#define CEC\_OP\_DIG\_SERVICE\_BCAST\_SYSTEM\_DVB\_T           0x1b
    \/\* Analogue Broadcast Type Operand (ana\_bcast\_type) \*\/
    \#define CEC\_OP\_ANA\_BCAST\_TYPE\_CABLE                     0
    \#define CEC\_OP\_ANA\_BCAST\_TYPE\_SATELLITE                 1
    \#define CEC\_OP\_ANA\_BCAST\_TYPE\_TERRESTRIAL               2
    \/\* Broadcast System Operand (bcast\_system) \*\/
    \#define CEC\_OP\_BCAST\_SYSTEM\_PAL\_BG                      0x00
    \#define CEC\_OP\_BCAST\_SYSTEM\_SECAM\_LQ                    0x01 \/\* SECAM L' \*\/
    \#define CEC\_OP\_BCAST\_SYSTEM\_PAL\_M                       0x02
    \#define CEC\_OP\_BCAST\_SYSTEM\_NTSC\_M                      0x03
    \#define CEC\_OP\_BCAST\_SYSTEM\_PAL\_I                       0x04
    \#define CEC\_OP\_BCAST\_SYSTEM\_SECAM\_DK                    0x05
    \#define CEC\_OP\_BCAST\_SYSTEM\_SECAM\_BG                    0x06
    \#define CEC\_OP\_BCAST\_SYSTEM\_SECAM\_L                     0x07
    \#define CEC\_OP\_BCAST\_SYSTEM\_PAL\_DK                      0x08
    \#define CEC\_OP\_BCAST\_SYSTEM\_OTHER                       0x1f
    \/\* Channel Number Format Operand (channel\_number\_fmt) \*\/
    \#define CEC\_OP\_CHANNEL\_NUMBER\_FMT\_1\_PART                0x01
    \#define CEC\_OP\_CHANNEL\_NUMBER\_FMT\_2\_PART                0x02

    \#define CEC\_MSG\_RECORD\_STATUS                           0x0a
    \/\* Record Status Operand (rec\_status) \*\/
    \#define CEC\_OP\_RECORD\_STATUS\_CUR\_SRC                    0x01
    \#define CEC\_OP\_RECORD\_STATUS\_DIG\_SERVICE                0x02
    \#define CEC\_OP\_RECORD\_STATUS\_ANA\_SERVICE                0x03
    \#define CEC\_OP\_RECORD\_STATUS\_EXT\_INPUT                  0x04
    \#define CEC\_OP\_RECORD\_STATUS\_NO\_DIG\_SERVICE             0x05
    \#define CEC\_OP\_RECORD\_STATUS\_NO\_ANA\_SERVICE             0x06
    \#define CEC\_OP\_RECORD\_STATUS\_NO\_SERVICE                 0x07
    \#define CEC\_OP\_RECORD\_STATUS\_INVALID\_EXT\_PLUG           0x09
    \#define CEC\_OP\_RECORD\_STATUS\_INVALID\_EXT\_PHYS\_ADDR      0x0a
    \#define CEC\_OP\_RECORD\_STATUS\_UNSUP\_CA                   0x0b
    \#define CEC\_OP\_RECORD\_STATUS\_NO\_CA\_ENTITLEMENTS         0x0c
    \#define CEC\_OP\_RECORD\_STATUS\_CANT\_COPY\_SRC              0x0d
    \#define CEC\_OP\_RECORD\_STATUS\_NO\_MORE\_COPIES             0x0e
    \#define CEC\_OP\_RECORD\_STATUS\_NO\_MEDIA                   0x10
    \#define CEC\_OP\_RECORD\_STATUS\_PLAYING                    0x11
    \#define CEC\_OP\_RECORD\_STATUS\_ALREADY\_RECORDING          0x12
    \#define CEC\_OP\_RECORD\_STATUS\_MEDIA\_PROT                 0x13
    \#define CEC\_OP\_RECORD\_STATUS\_NO\_SIGNAL                  0x14
    \#define CEC\_OP\_RECORD\_STATUS\_MEDIA\_PROBLEM              0x15
    \#define CEC\_OP\_RECORD\_STATUS\_NO\_SPACE                   0x16
    \#define CEC\_OP\_RECORD\_STATUS\_PARENTAL\_LOCK              0x17
    \#define CEC\_OP\_RECORD\_STATUS\_TERMINATED\_OK              0x1a
    \#define CEC\_OP\_RECORD\_STATUS\_ALREADY\_TERM               0x1b
    \#define CEC\_OP\_RECORD\_STATUS\_OTHER                      0x1f

    \#define CEC\_MSG\_RECORD\_TV\_SCREEN                        0x0f

    \/\* Timer Programming Feature \*\/
    \#define CEC\_MSG\_CLEAR\_ANALOGUE\_TIMER                    0x33
    \/\* Recording Sequence Operand (recording\_seq) \*\/
    \#define CEC\_OP\_REC\_SEQ\_SUNDAY                           0x01
    \#define CEC\_OP\_REC\_SEQ\_MONDAY                           0x02
    \#define CEC\_OP\_REC\_SEQ\_TUESDAY                          0x04
    \#define CEC\_OP\_REC\_SEQ\_WEDNESDAY                        0x08
    \#define CEC\_OP\_REC\_SEQ\_THURSDAY                         0x10
    \#define CEC\_OP\_REC\_SEQ\_FRIDAY                           0x20
    \#define CEC\_OP\_REC\_SEQ\_SATERDAY                         0x40
    \#define CEC\_OP\_REC\_SEQ\_ONCE\_ONLY                        0x00

    \#define CEC\_MSG\_CLEAR\_DIGITAL\_TIMER                     0x99

    \#define CEC\_MSG\_CLEAR\_EXT\_TIMER                         0xa1
    \/\* External Source Specifier Operand (ext\_src\_spec) \*\/
    \#define CEC\_OP\_EXT\_SRC\_PLUG                             0x04
    \#define CEC\_OP\_EXT\_SRC\_PHYS\_ADDR                        0x05

    \#define CEC\_MSG\_SET\_ANALOGUE\_TIMER                      0x34
    \#define CEC\_MSG\_SET\_DIGITAL\_TIMER                       0x97
    \#define CEC\_MSG\_SET\_EXT\_TIMER                           0xa2

    \#define CEC\_MSG\_SET\_TIMER\_PROGRAM\_TITLE                 0x67
    \#define CEC\_MSG\_TIMER\_CLEARED\_STATUS                    0x43
    \/\* Timer Cleared Status Data Operand (timer\_cleared\_status) \*\/
    \#define CEC\_OP\_TIMER\_CLR\_STAT\_RECORDING                 0x00
    \#define CEC\_OP\_TIMER\_CLR\_STAT\_NO\_MATCHING               0x01
    \#define CEC\_OP\_TIMER\_CLR\_STAT\_NO\_INFO                   0x02
    \#define CEC\_OP\_TIMER\_CLR\_STAT\_CLEARED                   0x80

    \#define CEC\_MSG\_TIMER\_STATUS                            0x35
    \/\* Timer Overlap Warning Operand (timer\_overlap\_warning) \*\/
    \#define CEC\_OP\_TIMER\_OVERLAP\_WARNING\_NO\_OVERLAP         0
    \#define CEC\_OP\_TIMER\_OVERLAP\_WARNING\_OVERLAP            1
    \/\* Media Info Operand (media\_info) \*\/
    \#define CEC\_OP\_MEDIA\_INFO\_UNPROT\_MEDIA                  0
    \#define CEC\_OP\_MEDIA\_INFO\_PROT\_MEDIA                    1
    \#define CEC\_OP\_MEDIA\_INFO\_NO\_MEDIA                      2
    \/\* Programmed Indicator Operand (prog\_indicator) \*\/
    \#define CEC\_OP\_PROG\_IND\_NOT\_PROGRAMMED                  0
    \#define CEC\_OP\_PROG\_IND\_PROGRAMMED                      1
    \/\* Programmed Info Operand (prog\_info) \*\/
    \#define CEC\_OP\_PROG\_INFO\_ENOUGH\_SPACE                   0x08
    \#define CEC\_OP\_PROG\_INFO\_NOT\_ENOUGH\_SPACE               0x09
    \#define CEC\_OP\_PROG\_INFO\_MIGHT\_NOT\_BE\_ENOUGH\_SPACE      0x0b
    \#define CEC\_OP\_PROG\_INFO\_NONE\_AVAILABLE                 0x0a
    \/\* Not Programmed Error Info Operand (prog\_error) \*\/
    \#define CEC\_OP\_PROG\_ERROR\_NO\_FREE\_TIMER                 0x01
    \#define CEC\_OP\_PROG\_ERROR\_DATE\_OUT\_OF\_RANGE             0x02
    \#define CEC\_OP\_PROG\_ERROR\_REC\_SEQ\_ERROR                 0x03
    \#define CEC\_OP\_PROG\_ERROR\_INV\_EXT\_PLUG                  0x04
    \#define CEC\_OP\_PROG\_ERROR\_INV\_EXT\_PHYS\_ADDR             0x05
    \#define CEC\_OP\_PROG\_ERROR\_CA\_UNSUPP                     0x06
    \#define CEC\_OP\_PROG\_ERROR\_INSUF\_CA\_ENTITLEMENTS         0x07
    \#define CEC\_OP\_PROG\_ERROR\_RESOLUTION\_UNSUPP             0x08
    \#define CEC\_OP\_PROG\_ERROR\_PARENTAL\_LOCK                 0x09
    \#define CEC\_OP\_PROG\_ERROR\_CLOCK\_FAILURE                 0x0a
    \#define CEC\_OP\_PROG\_ERROR\_DUPLICATE                     0x0e

    \/\* System Information Feature \*\/
    \#define CEC\_MSG\_CEC\_VERSION                             0x9e
    \/\* CEC Version Operand (cec\_version) \*\/
    \#define CEC\_OP\_CEC\_VERSION\_1\_3A                         4
    \#define CEC\_OP\_CEC\_VERSION\_1\_4                          5
    \#define CEC\_OP\_CEC\_VERSION\_2\_0                          6

    \#define CEC\_MSG\_GET\_CEC\_VERSION                         0x9f
    \#define CEC\_MSG\_GIVE\_PHYSICAL\_ADDR                      0x83
    \#define CEC\_MSG\_GET\_MENU\_LANGUAGE                       0x91
    \#define CEC\_MSG\_REPORT\_PHYSICAL\_ADDR                    0x84
    \/\* Primary Device Type Operand (prim\_devtype) \*\/
    \#define CEC\_OP\_PRIM\_DEVTYPE\_TV                          0
    \#define CEC\_OP\_PRIM\_DEVTYPE\_RECORD                      1
    \#define CEC\_OP\_PRIM\_DEVTYPE\_TUNER                       3
    \#define CEC\_OP\_PRIM\_DEVTYPE\_PLAYBACK                    4
    \#define CEC\_OP\_PRIM\_DEVTYPE\_AUDIOSYSTEM                 5
    \#define CEC\_OP\_PRIM\_DEVTYPE\_SWITCH                      6
    \#define CEC\_OP\_PRIM\_DEVTYPE\_PROCESSOR                   7

    \#define CEC\_MSG\_SET\_MENU\_LANGUAGE                       0x32
    \#define CEC\_MSG\_REPORT\_FEATURES                         0xa6    \/\* HDMI 2.0 \*\/
    \/\* All Device Types Operand (all\_device\_types) \*\/
    \#define CEC\_OP\_ALL\_DEVTYPE\_TV                           0x80
    \#define CEC\_OP\_ALL\_DEVTYPE\_RECORD                       0x40
    \#define CEC\_OP\_ALL\_DEVTYPE\_TUNER                        0x20
    \#define CEC\_OP\_ALL\_DEVTYPE\_PLAYBACK                     0x10
    \#define CEC\_OP\_ALL\_DEVTYPE\_AUDIOSYSTEM                  0x08
    \#define CEC\_OP\_ALL\_DEVTYPE\_SWITCH                       0x04
    \/\*
     \* And if you wondering what happened to PROCESSOR devices\: those should
     \* be mapped to a SWITCH.
     \*\/

    \/\* Valid for RC Profile and Device Feature operands \*\/
    \#define CEC\_OP\_FEAT\_EXT                                 0x80    \/\* Extension bit \*\/
    \/\* RC Profile Operand (rc\_profile) \*\/
    \#define CEC\_OP\_FEAT\_RC\_TV\_PROFILE\_NONE                  0x00
    \#define CEC\_OP\_FEAT\_RC\_TV\_PROFILE\_1                     0x02
    \#define CEC\_OP\_FEAT\_RC\_TV\_PROFILE\_2                     0x06
    \#define CEC\_OP\_FEAT\_RC\_TV\_PROFILE\_3                     0x0a
    \#define CEC\_OP\_FEAT\_RC\_TV\_PROFILE\_4                     0x0e
    \#define CEC\_OP\_FEAT\_RC\_SRC\_HAS\_DEV\_ROOT\_MENU            0x50
    \#define CEC\_OP\_FEAT\_RC\_SRC\_HAS\_DEV\_SETUP\_MENU           0x48
    \#define CEC\_OP\_FEAT\_RC\_SRC\_HAS\_CONTENTS\_MENU            0x44
    \#define CEC\_OP\_FEAT\_RC\_SRC\_HAS\_MEDIA\_TOP\_MENU           0x42
    \#define CEC\_OP\_FEAT\_RC\_SRC\_HAS\_MEDIA\_CONTEXT\_MENU       0x41
    \/\* Device Feature Operand (dev\_features) \*\/
    \#define CEC\_OP\_FEAT\_DEV\_HAS\_RECORD\_TV\_SCREEN            0x40
    \#define CEC\_OP\_FEAT\_DEV\_HAS\_SET\_OSD\_STRING              0x20
    \#define CEC\_OP\_FEAT\_DEV\_HAS\_DECK\_CONTROL                0x10
    \#define CEC\_OP\_FEAT\_DEV\_HAS\_SET\_AUDIO\_RATE              0x08
    \#define CEC\_OP\_FEAT\_DEV\_SINK\_HAS\_ARC\_TX                 0x04
    \#define CEC\_OP\_FEAT\_DEV\_SOURCE\_HAS\_ARC\_RX               0x02

    \#define CEC\_MSG\_GIVE\_FEATURES                           0xa5    \/\* HDMI 2.0 \*\/

    \/\* Deck Control Feature \*\/
    \#define CEC\_MSG\_DECK\_CONTROL                            0x42
    \/\* Deck Control Mode Operand (deck\_control\_mode) \*\/
    \#define CEC\_OP\_DECK\_CTL\_MODE\_SKIP\_FWD                   1
    \#define CEC\_OP\_DECK\_CTL\_MODE\_SKIP\_REV                   2
    \#define CEC\_OP\_DECK\_CTL\_MODE\_STOP                       3
    \#define CEC\_OP\_DECK\_CTL\_MODE\_EJECT                      4

    \#define CEC\_MSG\_DECK\_STATUS                             0x1b
    \/\* Deck Info Operand (deck\_info) \*\/
    \#define CEC\_OP\_DECK\_INFO\_PLAY                           0x11
    \#define CEC\_OP\_DECK\_INFO\_RECORD                         0x12
    \#define CEC\_OP\_DECK\_INFO\_PLAY\_REV                       0x13
    \#define CEC\_OP\_DECK\_INFO\_STILL                          0x14
    \#define CEC\_OP\_DECK\_INFO\_SLOW                           0x15
    \#define CEC\_OP\_DECK\_INFO\_SLOW\_REV                       0x16
    \#define CEC\_OP\_DECK\_INFO\_FAST\_FWD                       0x17
    \#define CEC\_OP\_DECK\_INFO\_FAST\_REV                       0x18
    \#define CEC\_OP\_DECK\_INFO\_NO\_MEDIA                       0x19
    \#define CEC\_OP\_DECK\_INFO\_STOP                           0x1a
    \#define CEC\_OP\_DECK\_INFO\_SKIP\_FWD                       0x1b
    \#define CEC\_OP\_DECK\_INFO\_SKIP\_REV                       0x1c
    \#define CEC\_OP\_DECK\_INFO\_INDEX\_SEARCH\_FWD               0x1d
    \#define CEC\_OP\_DECK\_INFO\_INDEX\_SEARCH\_REV               0x1e
    \#define CEC\_OP\_DECK\_INFO\_OTHER                          0x1f

    \#define CEC\_MSG\_GIVE\_DECK\_STATUS                        0x1a
    \/\* Status Request Operand (status\_req) \*\/
    \#define CEC\_OP\_STATUS\_REQ\_ON                            1
    \#define CEC\_OP\_STATUS\_REQ\_OFF                           2
    \#define CEC\_OP\_STATUS\_REQ\_ONCE                          3

    \#define CEC\_MSG\_PLAY                                    0x41
    \/\* Play Mode Operand (play\_mode) \*\/
    \#define CEC\_OP\_PLAY\_MODE\_PLAY\_FWD                       0x24
    \#define CEC\_OP\_PLAY\_MODE\_PLAY\_REV                       0x20
    \#define CEC\_OP\_PLAY\_MODE\_PLAY\_STILL                     0x25
    \#define CEC\_OP\_PLAY\_MODE\_PLAY\_FAST\_FWD\_MIN              0x05
    \#define CEC\_OP\_PLAY\_MODE\_PLAY\_FAST\_FWD\_MED              0x06
    \#define CEC\_OP\_PLAY\_MODE\_PLAY\_FAST\_FWD\_MAX              0x07
    \#define CEC\_OP\_PLAY\_MODE\_PLAY\_FAST\_REV\_MIN              0x09
    \#define CEC\_OP\_PLAY\_MODE\_PLAY\_FAST\_REV\_MED              0x0a
    \#define CEC\_OP\_PLAY\_MODE\_PLAY\_FAST\_REV\_MAX              0x0b
    \#define CEC\_OP\_PLAY\_MODE\_PLAY\_SLOW\_FWD\_MIN              0x15
    \#define CEC\_OP\_PLAY\_MODE\_PLAY\_SLOW\_FWD\_MED              0x16
    \#define CEC\_OP\_PLAY\_MODE\_PLAY\_SLOW\_FWD\_MAX              0x17
    \#define CEC\_OP\_PLAY\_MODE\_PLAY\_SLOW\_REV\_MIN              0x19
    \#define CEC\_OP\_PLAY\_MODE\_PLAY\_SLOW\_REV\_MED              0x1a
    \#define CEC\_OP\_PLAY\_MODE\_PLAY\_SLOW\_REV\_MAX              0x1b

    \/\* Tuner Control Feature \*\/
    \#define CEC\_MSG\_GIVE\_TUNER\_DEVICE\_STATUS                0x08
    \#define CEC\_MSG\_SELECT\_ANALOGUE\_SERVICE                 0x92
    \#define CEC\_MSG\_SELECT\_DIGITAL\_SERVICE                  0x93
    \#define CEC\_MSG\_TUNER\_DEVICE\_STATUS                     0x07
    \/\* Recording Flag Operand (rec\_flag) \*\/
    \#define CEC\_OP\_REC\_FLAG\_NOT\_USED                        0
    \#define CEC\_OP\_REC\_FLAG\_USED                            1
    \/\* Tuner Display Info Operand (tuner\_display\_info) \*\/
    \#define CEC\_OP\_TUNER\_DISPLAY\_INFO\_DIGITAL               0
    \#define CEC\_OP\_TUNER\_DISPLAY\_INFO\_NONE                  1
    \#define CEC\_OP\_TUNER\_DISPLAY\_INFO\_ANALOGUE              2

    \#define CEC\_MSG\_TUNER\_STEP\_DECREMENT                    0x06
    \#define CEC\_MSG\_TUNER\_STEP\_INCREMENT                    0x05

    \/\* Vendor Specific Commands Feature \*\/

    \/\*
     \* Has also\:
     \*      CEC\_MSG\_CEC\_VERSION
     \*      CEC\_MSG\_GET\_CEC\_VERSION
     \*\/
    \#define CEC\_MSG\_DEVICE\_VENDOR\_ID                        0x87
    \#define CEC\_MSG\_GIVE\_DEVICE\_VENDOR\_ID                   0x8c
    \#define CEC\_MSG\_VENDOR\_COMMAND                          0x89
    \#define CEC\_MSG\_VENDOR\_COMMAND\_WITH\_ID                  0xa0
    \#define CEC\_MSG\_VENDOR\_REMOTE\_BUTTON\_DOWN               0x8a
    \#define CEC\_MSG\_VENDOR\_REMOTE\_BUTTON\_UP                 0x8b

    \/\* OSD Display Feature \*\/
    \#define CEC\_MSG\_SET\_OSD\_STRING                          0x64
    \/\* Display Control Operand (disp\_ctl) \*\/
    \#define CEC\_OP\_DISP\_CTL\_DEFAULT                         0x00
    \#define CEC\_OP\_DISP\_CTL\_UNTIL\_CLEARED                   0x40
    \#define CEC\_OP\_DISP\_CTL\_CLEAR                           0x80

    \/\* Device OSD Transfer Feature \*\/
    \#define CEC\_MSG\_GIVE\_OSD\_NAME                           0x46
    \#define CEC\_MSG\_SET\_OSD\_NAME                            0x47

    \/\* Device Menu Control Feature \*\/
    \#define CEC\_MSG\_MENU\_REQUEST                            0x8d
    \/\* Menu Request Type Operand (menu\_req) \*\/
    \#define CEC\_OP\_MENU\_REQUEST\_ACTIVATE                    0x00
    \#define CEC\_OP\_MENU\_REQUEST\_DEACTIVATE                  0x01
    \#define CEC\_OP\_MENU\_REQUEST\_QUERY                       0x02

    \#define CEC\_MSG\_MENU\_STATUS                             0x8e
    \/\* Menu State Operand (menu\_state) \*\/
    \#define CEC\_OP\_MENU\_STATE\_ACTIVATED                     0x00
    \#define CEC\_OP\_MENU\_STATE\_DEACTIVATED                   0x01

    \#define CEC\_MSG\_USER\_CONTROL\_PRESSED                    0x44
    \/\* UI Command Operand (ui\_cmd) \*\/
    \#define CEC\_OP\_UI\_CMD\_SELECT                            0x00
    \#define CEC\_OP\_UI\_CMD\_UP                                0x01
    \#define CEC\_OP\_UI\_CMD\_DOWN                              0x02
    \#define CEC\_OP\_UI\_CMD\_LEFT                              0x03
    \#define CEC\_OP\_UI\_CMD\_RIGHT                             0x04
    \#define CEC\_OP\_UI\_CMD\_RIGHT\_UP                          0x05
    \#define CEC\_OP\_UI\_CMD\_RIGHT\_DOWN                        0x06
    \#define CEC\_OP\_UI\_CMD\_LEFT\_UP                           0x07
    \#define CEC\_OP\_UI\_CMD\_LEFT\_DOWN                         0x08
    \#define CEC\_OP\_UI\_CMD\_DEVICE\_ROOT\_MENU                  0x09
    \#define CEC\_OP\_UI\_CMD\_DEVICE\_SETUP\_MENU                 0x0a
    \#define CEC\_OP\_UI\_CMD\_CONTENTS\_MENU                     0x0b
    \#define CEC\_OP\_UI\_CMD\_FAVORITE\_MENU                     0x0c
    \#define CEC\_OP\_UI\_CMD\_BACK                              0x0d
    \#define CEC\_OP\_UI\_CMD\_MEDIA\_TOP\_MENU                    0x10
    \#define CEC\_OP\_UI\_CMD\_MEDIA\_CONTEXT\_SENSITIVE\_MENU      0x11
    \#define CEC\_OP\_UI\_CMD\_NUMBER\_ENTRY\_MODE                 0x1d
    \#define CEC\_OP\_UI\_CMD\_NUMBER\_11                         0x1e
    \#define CEC\_OP\_UI\_CMD\_NUMBER\_12                         0x1f
    \#define CEC\_OP\_UI\_CMD\_NUMBER\_0\_OR\_NUMBER\_10             0x20
    \#define CEC\_OP\_UI\_CMD\_NUMBER\_1                          0x21
    \#define CEC\_OP\_UI\_CMD\_NUMBER\_2                          0x22
    \#define CEC\_OP\_UI\_CMD\_NUMBER\_3                          0x23
    \#define CEC\_OP\_UI\_CMD\_NUMBER\_4                          0x24
    \#define CEC\_OP\_UI\_CMD\_NUMBER\_5                          0x25
    \#define CEC\_OP\_UI\_CMD\_NUMBER\_6                          0x26
    \#define CEC\_OP\_UI\_CMD\_NUMBER\_7                          0x27
    \#define CEC\_OP\_UI\_CMD\_NUMBER\_8                          0x28
    \#define CEC\_OP\_UI\_CMD\_NUMBER\_9                          0x29
    \#define CEC\_OP\_UI\_CMD\_DOT                               0x2a
    \#define CEC\_OP\_UI\_CMD\_ENTER                             0x2b
    \#define CEC\_OP\_UI\_CMD\_CLEAR                             0x2c
    \#define CEC\_OP\_UI\_CMD\_NEXT\_FAVORITE                     0x2f
    \#define CEC\_OP\_UI\_CMD\_CHANNEL\_UP                        0x30
    \#define CEC\_OP\_UI\_CMD\_CHANNEL\_DOWN                      0x31
    \#define CEC\_OP\_UI\_CMD\_PREVIOUS\_CHANNEL                  0x32
    \#define CEC\_OP\_UI\_CMD\_SOUND\_SELECT                      0x33
    \#define CEC\_OP\_UI\_CMD\_INPUT\_SELECT                      0x34
    \#define CEC\_OP\_UI\_CMD\_DISPLAY\_INFORMATION               0x35
    \#define CEC\_OP\_UI\_CMD\_HELP                              0x36
    \#define CEC\_OP\_UI\_CMD\_PAGE\_UP                           0x37
    \#define CEC\_OP\_UI\_CMD\_PAGE\_DOWN                         0x38
    \#define CEC\_OP\_UI\_CMD\_POWER                             0x40
    \#define CEC\_OP\_UI\_CMD\_VOLUME\_UP                         0x41
    \#define CEC\_OP\_UI\_CMD\_VOLUME\_DOWN                       0x42
    \#define CEC\_OP\_UI\_CMD\_MUTE                              0x43
    \#define CEC\_OP\_UI\_CMD\_PLAY                              0x44
    \#define CEC\_OP\_UI\_CMD\_STOP                              0x45
    \#define CEC\_OP\_UI\_CMD\_PAUSE                             0x46
    \#define CEC\_OP\_UI\_CMD\_RECORD                            0x47
    \#define CEC\_OP\_UI\_CMD\_REWIND                            0x48
    \#define CEC\_OP\_UI\_CMD\_FAST\_FORWARD                      0x49
    \#define CEC\_OP\_UI\_CMD\_EJECT                             0x4a
    \#define CEC\_OP\_UI\_CMD\_SKIP\_FORWARD                      0x4b
    \#define CEC\_OP\_UI\_CMD\_SKIP\_BACKWARD                     0x4c
    \#define CEC\_OP\_UI\_CMD\_STOP\_RECORD                       0x4d
    \#define CEC\_OP\_UI\_CMD\_PAUSE\_RECORD                      0x4e
    \#define CEC\_OP\_UI\_CMD\_ANGLE                             0x50
    \#define CEC\_OP\_UI\_CMD\_SUB\_PICTURE                       0x51
    \#define CEC\_OP\_UI\_CMD\_VIDEO\_ON\_DEMAND                   0x52
    \#define CEC\_OP\_UI\_CMD\_ELECTRONIC\_PROGRAM\_GUIDE          0x53
    \#define CEC\_OP\_UI\_CMD\_TIMER\_PROGRAMMING                 0x54
    \#define CEC\_OP\_UI\_CMD\_INITIAL\_CONFIGURATION             0x55
    \#define CEC\_OP\_UI\_CMD\_SELECT\_BROADCAST\_TYPE             0x56
    \#define CEC\_OP\_UI\_CMD\_SELECT\_SOUND\_PRESENTATION         0x57
    \#define CEC\_OP\_UI\_CMD\_AUDIO\_DESCRIPTION                 0x58
    \#define CEC\_OP\_UI\_CMD\_INTERNET                          0x59
    \#define CEC\_OP\_UI\_CMD\_3D\_MODE                           0x5a
    \#define CEC\_OP\_UI\_CMD\_PLAY\_FUNCTION                     0x60
    \#define CEC\_OP\_UI\_CMD\_PAUSE\_PLAY\_FUNCTION               0x61
    \#define CEC\_OP\_UI\_CMD\_RECORD\_FUNCTION                   0x62
    \#define CEC\_OP\_UI\_CMD\_PAUSE\_RECORD\_FUNCTION             0x63
    \#define CEC\_OP\_UI\_CMD\_STOP\_FUNCTION                     0x64
    \#define CEC\_OP\_UI\_CMD\_MUTE\_FUNCTION                     0x65
    \#define CEC\_OP\_UI\_CMD\_RESTORE\_VOLUME\_FUNCTION           0x66
    \#define CEC\_OP\_UI\_CMD\_TUNE\_FUNCTION                     0x67
    \#define CEC\_OP\_UI\_CMD\_SELECT\_MEDIA\_FUNCTION             0x68
    \#define CEC\_OP\_UI\_CMD\_SELECT\_AV\_INPUT\_FUNCTION          0x69
    \#define CEC\_OP\_UI\_CMD\_SELECT\_AUDIO\_INPUT\_FUNCTION       0x6a
    \#define CEC\_OP\_UI\_CMD\_POWER\_TOGGLE\_FUNCTION             0x6b
    \#define CEC\_OP\_UI\_CMD\_POWER\_OFF\_FUNCTION                0x6c
    \#define CEC\_OP\_UI\_CMD\_POWER\_ON\_FUNCTION                 0x6d
    \#define CEC\_OP\_UI\_CMD\_F1\_BLUE                           0x71
    \#define CEC\_OP\_UI\_CMD\_F2\_RED                            0x72
    \#define CEC\_OP\_UI\_CMD\_F3\_GREEN                          0x73
    \#define CEC\_OP\_UI\_CMD\_F4\_YELLOW                         0x74
    \#define CEC\_OP\_UI\_CMD\_F5                                0x75
    \#define CEC\_OP\_UI\_CMD\_DATA                              0x76
    \/\* UI Broadcast Type Operand (ui\_bcast\_type) \*\/
    \#define CEC\_OP\_UI\_BCAST\_TYPE\_TOGGLE\_ALL                 0x00
    \#define CEC\_OP\_UI\_BCAST\_TYPE\_TOGGLE\_DIG\_ANA             0x01
    \#define CEC\_OP\_UI\_BCAST\_TYPE\_ANALOGUE                   0x10
    \#define CEC\_OP\_UI\_BCAST\_TYPE\_ANALOGUE\_T                 0x20
    \#define CEC\_OP\_UI\_BCAST\_TYPE\_ANALOGUE\_CABLE             0x30
    \#define CEC\_OP\_UI\_BCAST\_TYPE\_ANALOGUE\_SAT               0x40
    \#define CEC\_OP\_UI\_BCAST\_TYPE\_DIGITAL                    0x50
    \#define CEC\_OP\_UI\_BCAST\_TYPE\_DIGITAL\_T                  0x60
    \#define CEC\_OP\_UI\_BCAST\_TYPE\_DIGITAL\_CABLE              0x70
    \#define CEC\_OP\_UI\_BCAST\_TYPE\_DIGITAL\_SAT                0x80
    \#define CEC\_OP\_UI\_BCAST\_TYPE\_DIGITAL\_COM\_SAT            0x90
    \#define CEC\_OP\_UI\_BCAST\_TYPE\_DIGITAL\_COM\_SAT2           0x91
    \#define CEC\_OP\_UI\_BCAST\_TYPE\_IP                         0xa0
    \/\* UI Sound Presentation Control Operand (ui\_snd\_pres\_ctl) \*\/
    \#define CEC\_OP\_UI\_SND\_PRES\_CTL\_DUAL\_MONO                0x10
    \#define CEC\_OP\_UI\_SND\_PRES\_CTL\_KARAOKE                  0x20
    \#define CEC\_OP\_UI\_SND\_PRES\_CTL\_DOWNMIX                  0x80
    \#define CEC\_OP\_UI\_SND\_PRES\_CTL\_REVERB                   0x90
    \#define CEC\_OP\_UI\_SND\_PRES\_CTL\_EQUALIZER                0xa0
    \#define CEC\_OP\_UI\_SND\_PRES\_CTL\_BASS\_UP                  0xb1
    \#define CEC\_OP\_UI\_SND\_PRES\_CTL\_BASS\_NEUTRAL             0xb2
    \#define CEC\_OP\_UI\_SND\_PRES\_CTL\_BASS\_DOWN                0xb3
    \#define CEC\_OP\_UI\_SND\_PRES\_CTL\_TREBLE\_UP                0xc1
    \#define CEC\_OP\_UI\_SND\_PRES\_CTL\_TREBLE\_NEUTRAL           0xc2
    \#define CEC\_OP\_UI\_SND\_PRES\_CTL\_TREBLE\_DOWN              0xc3

    \#define CEC\_MSG\_USER\_CONTROL\_RELEASED                   0x45

    \/\* Remote Control Passthrough Feature \*\/

    \/\*
     \* Has also\:
     \*      CEC\_MSG\_USER\_CONTROL\_PRESSED
     \*      CEC\_MSG\_USER\_CONTROL\_RELEASED
     \*\/

    \/\* Power Status Feature \*\/
    \#define CEC\_MSG\_GIVE\_DEVICE\_POWER\_STATUS                0x8f
    \#define CEC\_MSG\_REPORT\_POWER\_STATUS                     0x90
    \/\* Power Status Operand (pwr\_state) \*\/
    \#define CEC\_OP\_POWER\_STATUS\_ON                          0
    \#define CEC\_OP\_POWER\_STATUS\_STANDBY                     1
    \#define CEC\_OP\_POWER\_STATUS\_TO\_ON                       2
    \#define CEC\_OP\_POWER\_STATUS\_TO\_STANDBY                  3

    \/\* General Protocol Messages \*\/
    \#define CEC\_MSG\_FEATURE\_ABORT                           0x00
    \/\* Abort Reason Operand (reason) \*\/
    \#define CEC\_OP\_ABORT\_UNRECOGNIZED\_OP                    0
    \#define CEC\_OP\_ABORT\_INCORRECT\_MODE                     1
    \#define CEC\_OP\_ABORT\_NO\_SOURCE                          2
    \#define CEC\_OP\_ABORT\_INVALID\_OP                         3
    \#define CEC\_OP\_ABORT\_REFUSED                            4
    \#define CEC\_OP\_ABORT\_UNDETERMINED                       5

    \#define CEC\_MSG\_ABORT                                   0xff

    \/\* System Audio Control Feature \*\/

    \/\*
     \* Has also\:
     \*      CEC\_MSG\_USER\_CONTROL\_PRESSED
     \*      CEC\_MSG\_USER\_CONTROL\_RELEASED
     \*\/
    \#define CEC\_MSG\_GIVE\_AUDIO\_STATUS                       0x71
    \#define CEC\_MSG\_GIVE\_SYSTEM\_AUDIO\_MODE\_STATUS           0x7d
    \#define CEC\_MSG\_REPORT\_AUDIO\_STATUS                     0x7a
    \/\* Audio Mute Status Operand (aud\_mute\_status) \*\/
    \#define CEC\_OP\_AUD\_MUTE\_STATUS\_OFF                      0
    \#define CEC\_OP\_AUD\_MUTE\_STATUS\_ON                       1

    \#define CEC\_MSG\_REPORT\_SHORT\_AUDIO\_DESCRIPTOR           0xa3
    \#define CEC\_MSG\_REQUEST\_SHORT\_AUDIO\_DESCRIPTOR          0xa4
    \#define CEC\_MSG\_SET\_SYSTEM\_AUDIO\_MODE                   0x72
    \/\* System Audio Status Operand (sys\_aud\_status) \*\/
    \#define CEC\_OP\_SYS\_AUD\_STATUS\_OFF                       0
    \#define CEC\_OP\_SYS\_AUD\_STATUS\_ON                        1

    \#define CEC\_MSG\_SYSTEM\_AUDIO\_MODE\_REQUEST               0x70
    \#define CEC\_MSG\_SYSTEM\_AUDIO\_MODE\_STATUS                0x7e
    \/\* Audio Format ID Operand (audio\_format\_id) \*\/
    \#define CEC\_OP\_AUD\_FMT\_ID\_CEA861                        0
    \#define CEC\_OP\_AUD\_FMT\_ID\_CEA861\_CXT                    1

    \/\* Audio Rate Control Feature \*\/
    \#define CEC\_MSG\_SET\_AUDIO\_RATE                          0x9a
    \/\* Audio Rate Operand (audio\_rate) \*\/
    \#define CEC\_OP\_AUD\_RATE\_OFF                             0
    \#define CEC\_OP\_AUD\_RATE\_WIDE\_STD                        1
    \#define CEC\_OP\_AUD\_RATE\_WIDE\_FAST                       2
    \#define CEC\_OP\_AUD\_RATE\_WIDE\_SLOW                       3
    \#define CEC\_OP\_AUD\_RATE\_NARROW\_STD                      4
    \#define CEC\_OP\_AUD\_RATE\_NARROW\_FAST                     5
    \#define CEC\_OP\_AUD\_RATE\_NARROW\_SLOW                     6

    \/\* Audio Return Channel Control Feature \*\/
    \#define CEC\_MSG\_INITIATE\_ARC                            0xc0
    \#define CEC\_MSG\_REPORT\_ARC\_INITIATED                    0xc1
    \#define CEC\_MSG\_REPORT\_ARC\_TERMINATED                   0xc2
    \#define CEC\_MSG\_REQUEST\_ARC\_INITIATION                  0xc3
    \#define CEC\_MSG\_REQUEST\_ARC\_TERMINATION                 0xc4
    \#define CEC\_MSG\_TERMINATE\_ARC                           0xc5

    \/\* Dynamic Audio Lipsync Feature \*\/
    \/\* Only for CEC 2.0 and up \*\/
    \#define CEC\_MSG\_REQUEST\_CURRENT\_LATENCY                 0xa7
    \#define CEC\_MSG\_REPORT\_CURRENT\_LATENCY                  0xa8
    \/\* Low Latency Mode Operand (low\_latency\_mode) \*\/
    \#define CEC\_OP\_LOW\_LATENCY\_MODE\_OFF                     0
    \#define CEC\_OP\_LOW\_LATENCY\_MODE\_ON                      1
    \/\* Audio Output Compensated Operand (audio\_out\_compensated) \*\/
    \#define CEC\_OP\_AUD\_OUT\_COMPENSATED\_NA                   0
    \#define CEC\_OP\_AUD\_OUT\_COMPENSATED\_DELAY                1
    \#define CEC\_OP\_AUD\_OUT\_COMPENSATED\_NO\_DELAY             2
    \#define CEC\_OP\_AUD\_OUT\_COMPENSATED\_PARTIAL\_DELAY        3

    \/\* Capability Discovery and Control Feature \*\/
    \#define CEC\_MSG\_CDC\_MESSAGE                             0xf8
    \/\* Ethernet-over-HDMI\: nobody ever does this... \*\/
    \#define CEC\_MSG\_CDC\_HEC\_INQUIRE\_STATE                   0x00
    \#define CEC\_MSG\_CDC\_HEC\_REPORT\_STATE                    0x01
    \/\* HEC Functionality State Operand (hec\_func\_state) \*\/
    \#define CEC\_OP\_HEC\_FUNC\_STATE\_NOT\_SUPPORTED             0
    \#define CEC\_OP\_HEC\_FUNC\_STATE\_INACTIVE                  1
    \#define CEC\_OP\_HEC\_FUNC\_STATE\_ACTIVE                    2
    \#define CEC\_OP\_HEC\_FUNC\_STATE\_ACTIVATION\_FIELD          3
    \/\* Host Functionality State Operand (host\_func\_state) \*\/
    \#define CEC\_OP\_HOST\_FUNC\_STATE\_NOT\_SUPPORTED            0
    \#define CEC\_OP\_HOST\_FUNC\_STATE\_INACTIVE                 1
    \#define CEC\_OP\_HOST\_FUNC\_STATE\_ACTIVE                   2
    \/\* ENC Functionality State Operand (enc\_func\_state) \*\/
    \#define CEC\_OP\_ENC\_FUNC\_STATE\_EXT\_CON\_NOT\_SUPPORTED     0
    \#define CEC\_OP\_ENC\_FUNC\_STATE\_EXT\_CON\_INACTIVE          1
    \#define CEC\_OP\_ENC\_FUNC\_STATE\_EXT\_CON\_ACTIVE            2
    \/\* CDC Error Code Operand (cdc\_errcode) \*\/
    \#define CEC\_OP\_CDC\_ERROR\_CODE\_NONE                      0
    \#define CEC\_OP\_CDC\_ERROR\_CODE\_CAP\_UNSUPPORTED           1
    \#define CEC\_OP\_CDC\_ERROR\_CODE\_WRONG\_STATE               2
    \#define CEC\_OP\_CDC\_ERROR\_CODE\_OTHER                     3
    \/\* HEC Support Operand (hec\_support) \*\/
    \#define CEC\_OP\_HEC\_SUPPORT\_NO                           0
    \#define CEC\_OP\_HEC\_SUPPORT\_YES                          1
    \/\* HEC Activation Operand (hec\_activation) \*\/
    \#define CEC\_OP\_HEC\_ACTIVATION\_ON                        0
    \#define CEC\_OP\_HEC\_ACTIVATION\_OFF                       1

    \#define CEC\_MSG\_CDC\_HEC\_SET\_STATE\_ADJACENT              0x02
    \#define CEC\_MSG\_CDC\_HEC\_SET\_STATE                       0x03
    \/\* HEC Set State Operand (hec\_set\_state) \*\/
    \#define CEC\_OP\_HEC\_SET\_STATE\_DEACTIVATE                 0
    \#define CEC\_OP\_HEC\_SET\_STATE\_ACTIVATE                   1

    \#define CEC\_MSG\_CDC\_HEC\_REQUEST\_DEACTIVATION            0x04
    \#define CEC\_MSG\_CDC\_HEC\_NOTIFY\_ALIVE                    0x05
    \#define CEC\_MSG\_CDC\_HEC\_DISCOVER                        0x06
    \/\* Hotplug Detect messages \*\/
    \#define CEC\_MSG\_CDC\_HPD\_SET\_STATE                       0x10
    \/\* HPD State Operand (hpd\_state) \*\/
    \#define CEC\_OP\_HPD\_STATE\_CP\_EDID\_DISABLE                0
    \#define CEC\_OP\_HPD\_STATE\_CP\_EDID\_ENABLE                 1
    \#define CEC\_OP\_HPD\_STATE\_CP\_EDID\_DISABLE\_ENABLE         2
    \#define CEC\_OP\_HPD\_STATE\_EDID\_DISABLE                   3
    \#define CEC\_OP\_HPD\_STATE\_EDID\_ENABLE                    4
    \#define CEC\_OP\_HPD\_STATE\_EDID\_DISABLE\_ENABLE            5
    \#define CEC\_MSG\_CDC\_HPD\_REPORT\_STATE                    0x11
    \/\* HPD Error Code Operand (hpd\_error) \*\/
    \#define CEC\_OP\_HPD\_ERROR\_NONE                           0
    \#define CEC\_OP\_HPD\_ERROR\_INITIATOR\_NOT\_CAPABLE          1
    \#define CEC\_OP\_HPD\_ERROR\_INITIATOR\_WRONG\_STATE          2
    \#define CEC\_OP\_HPD\_ERROR\_OTHER                          3
    \#define CEC\_OP\_HPD\_ERROR\_NONE\_NO\_VIDEO                  4

    \/\* End of Messages \*\/

    \/\* Helper functions to identify the 'special' CEC devices \*\/

    static inline int cec\_is\_2nd\_tv(const struct cec_log_addrs \*las)
    \{
            \/\*
             \* It is a second TV if the logical address is 14 or 15 and the
             \* primary device type is a TV.
             \*\/
            return las-\>num\_log\_addrs \&\&
                   las-\>log\_addr[0] \>= CEC\_LOG\_ADDR\_SPECIFIC \&\&
                   las-\>primary\_device\_type[0] == CEC\_OP\_PRIM\_DEVTYPE\_TV;
    \}

    static inline int cec\_is\_processor(const struct cec_log_addrs \*las)
    \{
            \/\*
             \* It is a processor if the logical address is 12-15 and the
             \* primary device type is a Processor.
             \*\/
            return las-\>num\_log\_addrs \&\&
                   las-\>log\_addr[0] \>= CEC\_LOG\_ADDR\_BACKUP\_1 \&\&
                   las-\>primary\_device\_type[0] == CEC\_OP\_PRIM\_DEVTYPE\_PROCESSOR;
    \}

    static inline int cec\_is\_switch(const struct cec_log_addrs \*las)
    \{
            \/\*
             \* It is a switch if the logical address is 15 and the
             \* primary device type is a Switch and the CDC-Only flag is not set.
             \*\/
            return las-\>num\_log\_addrs == 1 \&\&
                   las-\>log\_addr[0] == CEC\_LOG\_ADDR\_UNREGISTERED \&\&
                   las-\>primary\_device\_type[0] == CEC\_OP\_PRIM\_DEVTYPE\_SWITCH \&\&
                   !(las-\>flags \& \ :ref:`CEC_LOG_ADDRS_FL_CDC_ONLY <cec-log-addrs-fl-cdc-only>`\ );
    \}

    static inline int cec\_is\_cdc\_only(const struct cec_log_addrs \*las)
    \{
            \/\*
             \* It is a CDC-only device if the logical address is 15 and the
             \* primary device type is a Switch and the CDC-Only flag is set.
             \*\/
            return las-\>num\_log\_addrs == 1 \&\&
                   las-\>log\_addr[0] == CEC\_LOG\_ADDR\_UNREGISTERED \&\&
                   las-\>primary\_device\_type[0] == CEC\_OP\_PRIM\_DEVTYPE\_SWITCH \&\&
                   (las-\>flags \& \ :ref:`CEC_LOG_ADDRS_FL_CDC_ONLY <cec-log-addrs-fl-cdc-only>`\ );
    \}

    \#endif
