Landlock: unprivileged access control
=====================================

.. toctree::
   :maxdepth: 2
   :caption: Contents:

The goal of Landlock is to enable to restrict ambient rights (e.g. global
filesystem access) for a set of processes.  Because Landlock is a stackable
LSM, it makes possible to create safe security sandboxes as new security layers
in addition to the existing system-wide access-controls. This kind of sandbox
is expected to help mitigate the security impact of bugs or
unexpected/malicious behaviors in user space applications.  Landlock empowers
any process, including unprivileged ones, to securely restrict themselves.


[PATCH v31] -- Landlock LSM
---------------------------

`LKML`__ -- `code`__ -- `sandbox manager example`__ -- `tests`__ -- `documentation`__

__ https://lore.kernel.org/lkml/20210324191520.125779-1-mic@digikod.net/
__ https://github.com/landlock-lsm/linux/commits/landlock-v31
__ https://github.com/landlock-lsm/linux/blob/landlock-v31/samples/landlock/sandboxer.c
__ https://github.com/landlock-lsm/linux/blob/landlock-v31/tools/testing/selftests/landlock/
__ linux-doc/landlock-v31/userspace-api/landlock.html


[PATCH v30] -- Landlock LSM
---------------------------

Landlock is now in Linux `next-20210319`__

__ https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/security/landlock?h=next-20210319&id=f00397ee41c79b6155b9b44abd0055b2c0621349


`LKML`__ -- `code`__ -- `sandbox manager example`__ -- `tests`__ -- `documentation`__

__ https://lore.kernel.org/lkml/20210316204252.427806-1-mic@digikod.net/
__ https://github.com/landlock-lsm/linux/commits/landlock-v30
__ https://github.com/landlock-lsm/linux/blob/landlock-v30/samples/landlock/sandboxer.c
__ https://github.com/landlock-lsm/linux/blob/landlock-v30/tools/testing/selftests/landlock/
__ linux-doc/landlock-v30/userspace-api/landlock.html


External links
==============

Twitter__ -- GitHub__

__ https://twitter.com/l0kod
__ https://github.com/landlock-lsm


Archives
========

Summary 2019 -- Landlock: a new kind of Linux Security Module leveraging eBPF
-----------------------------------------------------------------------------

`Slides`__

__ talks/2019-09-12_landlock-summary.pdf


[PATCH v10] -- Landlock LSM: toward unprivileged sandboxing
-----------------------------------------------------------

`LKML`__ -- `code`__ -- `program example`__ -- `documentation`__

__ https://lore.kernel.org/linux-security-module/20190721213116.23476-1-mic@digikod.net/
__ https://github.com/landlock-lsm/linux/commits/landlock-v10
__ https://github.com/landlock-lsm/linux/blob/landlock-v10/samples/bpf/landlock1_kern.c
__ linux-doc/landlock-v10/security/landlock/index.html


Linux Security Summit 2018 -- How to safely restrict access to files in a programmatic way with Landlock?
---------------------------------------------------------------------------------------------------------

`Abstract`__ -- `Slides`__ -- `Demo video #1 (web server)`__ -- `Demo video #2 (dynamic map update)`__ -- `Demo code`__

__ https://lssna18.sched.com/event/FLYR
__ talks/2018-08-27_landlock-lss.pdf
__ talks/2018-08-27_landlock-lss_demo-1-web.mkv
__ talks/2018-08-27_landlock-lss_demo-2-dynmap.mkv
__ https://github.com/landlock-lsm/linux/blob/landlock-v8/samples/bpf/landlock1_kern.c


Pass the SALT 2018 -- Internals of Landlock: a new kind of Linux Security Module leveraging eBPF
------------------------------------------------------------------------------------------------

`Abstract and video`__ -- `Slides`__ -- `Demo video #1 (web server)`__ -- `Demo video #2 (dynamic map update)`__ -- `Demo code`__

__ https://2018.pass-the-salt.org/programme/#landlock
__ talks/2018-07-04_landlock-pts.pdf
__ talks/2018-07-04_landlock-pts_demo-1-web.mkv
__ talks/2018-07-04_landlock-pts_demo-2-dynmap.mkv
__ https://github.com/landlock-lsm/linux/blob/landlock-v8/samples/bpf/landlock1_kern.c


[PATCH v8] -- Landlock LSM: toward unprivileged sandboxing
----------------------------------------------------------

`LKML`__ -- `code`__ -- `program example`__ -- `documentation`__

__ https://lkml.org/lkml/2018/2/26/1214
__ https://github.com/landlock-lsm/linux/commits/landlock-v8
__ https://github.com/landlock-lsm/linux/blob/landlock-v8/samples/bpf/landlock1_kern.c
__ linux-doc/landlock-v8/security/landlock/index.html


FOSDEM 2018 -- File access-control per container with Landlock
--------------------------------------------------------------

`Abstract and video`__ -- `Slides`__ -- `Demo video`__ -- `Demo code`__

__ https://fosdem.org/2018/schedule/event/containers_landlock/
__ talks/2018-02-04_landlock-fosdem.pdf
__ talks/2018-02-04_landlock-fosdem_demo.mkv
__ https://github.com/landlock-lsm/linux/blob/landlock-v8-alpha/samples/bpf/landlock1_kern.c


Linux Security Summit 2017 -- Landlock LSM: toward unprivileged sandboxing
--------------------------------------------------------------------------

`Slides`__ -- `Demo #1`__ -- `Demo #2`__

__ talks/2017-09-14_landlock-lss.pdf
__ talks/2017-09-14_landlock-lss_demo-1-ro-tty.mkv
__ talks/2017-09-14_landlock-lss_demo-2-fsview-gui.mkv


[PATCH v7] -- Landlock LSM: toward unprivileged sandboxing
----------------------------------------------------------

`LKML`__ -- `code`__ -- `rule example`__ -- `documentation`__

__ https://lkml.org/lkml/2017/8/20/192
__ https://github.com/landlock-lsm/linux/commits/landlock-v7
__ https://github.com/landlock-lsm/linux/blob/landlock-v7/samples/bpf/landlock1_kern.c
__ linux-doc/landlock-v7/security/landlock/index.html
