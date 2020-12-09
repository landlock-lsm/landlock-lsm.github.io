.. -*- coding: utf-8; mode: rst -*-

ca.h
====

.. parsed-literal::

    \/\* SPDX-License-Identifier\: LGPL-2.1+ WITH Linux-syscall-note \*\/
    \/\*
     \* ca.h
     \*
     \* Copyright (C) 2000 Ralph  Metzler \<ralph@convergence.de\>
     \*                  \& Marcus Metzler \<marcus@convergence.de\>
     \*                    for convergence integrated media GmbH
     \*
     \* This program is free software; you can redistribute it and\/or
     \* modify it under the terms of the GNU General Lesser Public License
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

    \#ifndef \_DVBCA\_H\_
    \#define \_DVBCA\_H\_

    \/\*\*
     \* struct ca_slot_info - CA slot interface types and info.
     \*
     \* @num\:        slot number.
     \* @type\:       slot type.
     \* @flags\:      flags applicable to the slot.
     \*
     \* This struct stores the CA slot information.
     \*
     \* @type can be\:
     \*
     \*      - \%CA\_CI - CI high level interface;
     \*      - \%CA\_CI\_LINK - CI link layer level interface;
     \*      - \%CA\_CI\_PHYS - CI physical layer level interface;
     \*      - \%CA\_DESCR - built-in descrambler;
     \*      - \%CA\_SC -simple smart card interface.
     \*
     \* @flags can be\:
     \*
     \*      - \%CA\_CI\_MODULE\_PRESENT - module (or card) inserted;
     \*      - \%CA\_CI\_MODULE\_READY - module is ready for usage.
     \*\/

    struct ca_slot_info \{
            int num;
            int type;
    \#define :c:type:`CA_CI <ca_slot_info>`            1
    \#define :c:type:`CA_CI_LINK <ca_slot_info>`       2
    \#define :c:type:`CA_CI_PHYS <ca_slot_info>`       4
    \#define :c:type:`CA_DESCR <ca_slot_info>`         8
    \#define :c:type:`CA_SC <ca_slot_info>`          128

            unsigned int flags;
    \#define :c:type:`CA_CI_MODULE_PRESENT <ca_slot_info>` 1
    \#define :c:type:`CA_CI_MODULE_READY <ca_slot_info>`   2
    \};

    \/\*\*
     \* struct ca_descr_info - descrambler types and info.
     \*
     \* @num\:        number of available descramblers (keys).
     \* @type\:       type of supported scrambling system.
     \*
     \* Identifies the number of descramblers and their type.
     \*
     \* @type can be\:
     \*
     \*      - \%CA\_ECD - European Common Descrambler (ECD) hardware;
     \*      - \%CA\_NDS - Videoguard (NDS) hardware;
     \*      - \%CA\_DSS - Distributed Sample Scrambling (DSS) hardware.
     \*\/
    struct ca_descr_info \{
            unsigned int num;
            unsigned int type;
    \#define :c:type:`CA_ECD <ca_descr_info>`           1
    \#define :c:type:`CA_NDS <ca_descr_info>`           2
    \#define :c:type:`CA_DSS <ca_descr_info>`           4
    \};

    \/\*\*
     \* struct ca_caps - CA slot interface capabilities.
     \*
     \* @slot\_num\:   total number of CA card and module slots.
     \* @slot\_type\:  bitmap with all supported types as defined at
     \*              \&struct ca_slot_info (e. g. \%CA\_CI, \%CA\_CI\_LINK, etc).
     \* @descr\_num\:  total number of descrambler slots (keys)
     \* @descr\_type\: bitmap with all supported types as defined at
     \*              \&struct ca_descr_info (e. g. \%CA\_ECD, \%CA\_NDS, etc).
     \*\/
    struct ca_caps \{
            unsigned int slot\_num;
            unsigned int slot\_type;
            unsigned int descr\_num;
            unsigned int descr\_type;
    \};

    \/\*\*
     \* struct ca_msg - a message to\/from a CI-CAM
     \*
     \* @index\:      unused
     \* @type\:       unused
     \* @length\:     length of the message
     \* @msg\:        message
     \*
     \* This struct carries a message to be send\/received from a CI CA module.
     \*\/
    struct ca_msg \{
            unsigned int index;
            unsigned int type;
            unsigned int length;
            unsigned char msg[256];
    \};

    \/\*\*
     \* struct ca_descr - CA descrambler control words info
     \*
     \* @index\: CA Descrambler slot
     \* @parity\: control words parity, where 0 means even and 1 means odd
     \* @cw\: CA Descrambler control words
     \*\/
    struct ca_descr \{
            unsigned int index;
            unsigned int parity;
            unsigned char cw[8];
    \};

    \#define \ :ref:`CA_RESET <ca_reset>`          \_IO('o', 128)
    \#define \ :ref:`CA_GET_CAP <ca_get_cap>`        \_IOR('o', 129, struct ca_caps\ )
    \#define \ :ref:`CA_GET_SLOT_INFO <ca_get_slot_info>`  \_IOR('o', 130, struct ca_slot_info\ )
    \#define \ :ref:`CA_GET_DESCR_INFO <ca_get_descr_info>` \_IOR('o', 131, struct ca_descr_info\ )
    \#define \ :ref:`CA_GET_MSG <ca_get_msg>`        \_IOR('o', 132, struct ca_msg\ )
    \#define \ :ref:`CA_SEND_MSG <ca_send_msg>`       \_IOW('o', 133, struct ca_msg\ )
    \#define \ :ref:`CA_SET_DESCR <ca_set_descr>`      \_IOW('o', 134, struct ca_descr\ )

    \#if !defined(\_\_KERNEL\_\_)

    \/\* This is needed for legacy userspace support \*\/
    typedef struct ca_slot_info :c:type:`ca_slot_info_t <ca_slot_info>`;
    typedef struct ca_descr_info  :c:type:`ca_descr_info_t <ca_descr_info>`;
    typedef struct ca_caps  :c:type:`ca_caps_t <ca_caps>`;
    typedef struct ca_msg :c:type:`ca_msg_t <ca_msg>`;
    typedef struct ca_descr :c:type:`ca_descr_t <ca_descr>`;

    \#endif

    \#endif
