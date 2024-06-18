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


`Landlock documentation`__ -- `code`__ -- `sandbox manager example`__ -- `tests`__ -- `syzkaller coverage`__

__ https://docs.kernel.org/userspace-api/landlock.html
__ https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/landlock
__ https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/landlock/sandboxer.c
__ https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/landlock
__ https://storage.googleapis.com/syzkaller/cover/ci-upstream-linux-next-kasan-gce-root.html#security%2flandlock


News
----

* Newsletter (2023-03-22) - `Landlock news #3`__
* Linux 6.2 (2023-02-19) - `New LANDLOCK_ACCESS_FS_TRUNCATE`__
* Newsletter (2022-08-17) - `Landlock news #2`__
* Linux 5.19 (2022-07-31) - `New LANDLOCK_ACCESS_FS_REFER, improved documentation and 16 layers limit`__
* Newsletter (2021-09-01) - `Landlock news #1`__
* Linux 5.13 (2021-06-27) - `Initial Landlock version`__
* LWN article (2021-06-17) - `Landlock (finally) sets sail`__

__ https://lore.kernel.org/landlock/d4ed5733-d07b-5548-2534-a63e22906778@digikod.net/
__ https://git.kernel.org/torvalds/c/299e2b1967578b1442128ba8b3e86ed3427d3651
__ https://lore.kernel.org/landlock/441bd1cd-03fd-8e30-c370-3d0f0263d564@digikod.net/
__ https://git.kernel.org/torvalds/c/cb44e4f061e16be65b8a16505e121490c66d30d0
__ https://lore.kernel.org/landlock/2df4887a-1710-bba2-f49c-cd5b785bb565@digikod.net/
__ https://git.kernel.org/torvalds/c/17ae69aba89dbfa2139b7f8024b757ab3cc42f59
__ https://lwn.net/Articles/859908/


Conferences
-----------

* SSTIC (2024-06-06) - `Landlock: From a security mechanism idea to a widely available implementation`__ -- `article`__ and `slides`__
* Class and workshop (2024-01-22) `Landlock overview`__ and `Landlock workshop`__
* Kernel Recipes (2023-09-25) - `Update on Landlock: Audit, Debugging and Metrics`__ -- `slides`__
* Linux Security Summit Europe (2023-09-21) - `Landlock Workshop: Sandboxing Application for Fun and Protection`__ -- `slides`__
* Linux Security Summit Europe (2023-09-21) - `Update on Landlock: Audit, Debugging and Metrics`__ -- `slides`__
* FOSDEM (2023-02-04) - `Backward and forward compatibility for security features (illustrated with Landlock)`__ -- `slides`__
* Netdev 0x16 (2022-10-24) - `How to sandbox a network application with Landlock`__ -- `slides`__ and `tutorial files`__
* Pass the Salt (2022-07-04) - `Sandboxing your application with Landlock, illustration with the p7zip case`__ -- `slides`__ and `recording`__
* Linux Security Summit North America (2022-06-24) - `Update on Landlock: Lifting the File Reparenting Limits and Supporting Network Rules`__ -- `slides`__ and `recording`__
* Linux Security Summit (2021-09-29) - `Deep Dive into Landlock Internals`__ -- `slides`__ and `recording`__
* Open Source Summit (2021-09-28) - `Sandboxing Applications with Landlock`__ -- `slides`__ and `recording`__

__ https://www.sstic.org/2024/presentation/landlock-design/
__ talks/2024-06-06_landlock-article.pdf
__ talks/2024-06-06_landlock-design.pdf

__ talks/2024-01-22_landlock-overview.pdf
__ talks/2024-01-22_landlock-workshop.pdf

__ https://kernel-recipes.org/en/2023/update-on-landlock-audit-debugging-and-metrics/
__ talks/2023-09-25_landlock-audit-kr.pdf

__ https://sched.co/1OLAi
__ talks/2023-09-21_landlock-imagemagick-lss-eu.pdf

__ https://sched.co/1OL79
__ talks/2023-09-21_landlock-audit-lss-eu.pdf

__ https://fosdem.org/2023/schedule/event/rust_backward_and_forward_compatibility_for_security_features/
__ talks/2023-02-04_rust-landlock-fosdem.pdf

__ https://netdevconf.info/0x16/session.html?How-to-sandbox-a-network-application-with-Landlock
__ talks/2022-10-24_landlock-netdevconf.pdf
__ https://github.com/landlock-lsm/tuto-lighttpd

__ https://cfp.pass-the-salt.org/pts2022/talk/BGQGZC/
__ talks/2022-07-04_landlock-pts.pdf
__ https://passthesalt.ubicast.tv/videos/sandboxing-your-application-with-landlock-illustration-with-the-p7zip-case/

__ https://sched.co/11MXq
__ talks/2022-06-24_landlock-lss-na.pdf
__ https://youtu.be/MWjW-QwK_ZA

__ https://sched.co/ljRQ
__ talks/2021-09-29_landlock-lss.pdf
__ https://youtu.be/5Al2z0LTEMs

__ https://sched.co/lAVl
__ talks/2021-09-28_landlock-oss.pdf
__ https://youtu.be/ohoofZ62O98


Roadmap (kernel-side)
---------------------

See `Landlock tasks on GitHub`__.

__ https://github.com/orgs/landlock-lsm/projects/1

`Kernel development`__ still happens on the related mailing lists though.

__ https://docs.kernel.org/process/submitting-patches.html


External links
==============

Mastodon__ -- Twitter__ -- GitHub__

__ https://mastodon.social/@l0kod
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
