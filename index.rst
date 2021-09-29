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

`Mailing list`__ dedicated to user space development involving Landlock: `subscription`__, `posting`__ and `archives`__.

__ https://subspace.kernel.org/lists.linux.dev.html
__ mailto:landlock+subscribe@lists.linux.dev
__ mailto:landlock@lists.linux.dev
__ https://lore.kernel.org/landlock/


News
----

* Newsletter (2021-09-01) - `Landlock news #1`__
* LWN article (2021-06-17) - `Landlock (finally) sets sail`__

__ https://lore.kernel.org/landlock/2df4887a-1710-bba2-f49c-cd5b785bb565@digikod.net/
__ https://lwn.net/Articles/859908/


Conferences
-----------

* Open Source Summit (2021-09-28) - `Sandboxing Applications with Landlock`__ -- `slides`__ and `recording`__
* Linux Security Summit (2021-09-29) - `Deep Dive into Landlock Internals`__ -- `slides`__ and `recording`__

__ https://sched.co/lAVl
__ talks/2021-09-28_landlock-oss.pdf
__ https://youtu.be/ohoofZ62O98
__ https://sched.co/ljRQ
__ talks/2021-09-29_landlock-lss.pdf
__ https://youtu.be/5Al2z0LTEMs


Roadmap (kernel-side)
---------------------

Short term:
 * improve kernel performance for the current features;
 * add the ability to change the parent directory of files (see current Landlock limitations).

Medium term:
 * add audit features to ease debugging;
 * extend filesystem access-control types to address the current limitations;
 * add the ability to follow a deny listing approach, which is required for some use cases.

Long term:
 * add minimal network access-control types;
 * add the ability to create (file descriptor) capabilities compatible with Capsicum.


[PATCH v34] -- Landlock LSM
---------------------------

.. note::

    Merged in `mainline`__: will be available in Linux 5.13!

    __ https://git.kernel.org/torvalds/c/17ae69aba89dbfa2139b7f8024b757ab3cc42f59

`LKML`__ -- `code`__ -- `sandbox manager example`__ -- `tests`__ -- `documentation`__ -- `LCOV coverage`__ -- `syzkaller coverage`__

__ https://lore.kernel.org/lkml/20210422154123.13086-1-mic@digikod.net/
__ https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/security/landlock
__ https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/samples/landlock/sandboxer.c
__ https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/landlock
__ https://www.kernel.org/doc/html/latest/userspace-api/landlock.html
__ linux-lcov/landlock-v34/security/landlock/index.html
__ https://storage.googleapis.com/syzkaller/cover/ci-upstream-linux-next-kasan-gce-root.html#security%2flandlock


GNU Tar -- [PATCH v1] Landlock support
--------------------------------------

`patch`__ -- `code`__

__ https://lists.gnu.org/archive/html/bug-tar/2021-04/msg00001.html
__ https://github.com/landlock-lsm/tar/commits/landlock-v1


External links
==============

Twitter__ -- GitHub__

__ https://twitter.com/l0kod
__ https://github.com/landlock-lsm


Archives
========

.. warning::

    Landlock is not based on eBPF anymore.  These talks are outdated but kept for reference.


Summary 2019 -- Landlock: a new kind of Linux Security Module leveraging eBPF
-----------------------------------------------------------------------------

`Slides`__

__ talks/2019-09-12_landlock-summary.pdf


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
