.. -*- coding: utf-8; mode: rst -*-

net.h
=====

.. parsed-literal::

    \/\* SPDX-License-Identifier\: LGPL-2.1+ WITH Linux-syscall-note \*\/
    \/\*
     \* net.h
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

    \#ifndef \_DVBNET\_H\_
    \#define \_DVBNET\_H\_

    \#include \<linux\/types.h\>

    \/\*\*
     \* struct dvb_net_if - describes a DVB network interface
     \*
     \* @pid\: Packet ID (PID) of the MPEG-TS that contains data
     \* @if\_num\: number of the Digital TV interface.
     \* @feedtype\: Encapsulation type of the feed.
     \*
     \* A MPEG-TS stream may contain packet IDs with IP packages on it.
     \* This struct describes it, and the type of encoding.
     \*
     \* @feedtype can be\:
     \*
     \*      - \%DVB\_NET\_FEEDTYPE\_MPE for MPE encoding
     \*      - \%DVB\_NET\_FEEDTYPE\_ULE for ULE encoding.
     \*\/
    struct dvb_net_if \{
            \_\_u16 pid;
            \_\_u16 if\_num;
            \_\_u8  feedtype;
    \#define :c:type:`DVB_NET_FEEDTYPE_MPE <dvb_net_if>` 0  \/\* multi protocol encapsulation \*\/
    \#define :c:type:`DVB_NET_FEEDTYPE_ULE <dvb_net_if>` 1  \/\* ultra lightweight encapsulation \*\/
    \};

    \#define \ :ref:`NET_ADD_IF <net_add_if>`    \_IOWR('o', 52, struct dvb_net_if\ )
    \#define \ :ref:`NET_REMOVE_IF <net_remove_if>` \_IO('o', 53)
    \#define \ :ref:`NET_GET_IF <net_get_if>`    \_IOWR('o', 54, struct dvb_net_if\ )

    \/\* binary compatibility cruft\: \*\/
    struct \_\_dvb\_net\_if\_old \{
            \_\_u16 pid;
            \_\_u16 if\_num;
    \};
    \#define \_\_NET\_ADD\_IF\_OLD \_IOWR('o', 52, struct \_\_dvb\_net\_if\_old)
    \#define \_\_NET\_GET\_IF\_OLD \_IOWR('o', 54, struct \_\_dvb\_net\_if\_old)

    \#endif \/\*\_DVBNET\_H\_\*\/
