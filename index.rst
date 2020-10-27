Landlock: unprivileged access control
=====================================

.. toctree::
   :maxdepth: 2
   :caption: Contents:

The goal of Landlock is to enable to restrict ambient rights (e.g.  global
filesystem access) for a set of processes.  Because Landlock is a stackable
LSM, it makes possible to create safe security sandboxes as new security layers
in addition to the existing system-wide access-controls. This kind of sandbox
is expected to help mitigate the security impact of bugs or
unexpected/malicious behaviors in user-space applications. Landlock empower any
process, including unprivileged ones, to securely restrict themselves.


[PATCH v22] -- Landlock LSM
---------------------------

`LKML`__ -- `code`__ -- `sandbox manager example`__ -- `tests`__ -- `documentation`__

__ https://lore.kernel.org/linux-security-module/20201027200358.557003-1-mic@digikod.net/
__ https://github.com/landlock-lsm/linux/commits/landlock-v22
__ https://github.com/landlock-lsm/linux/blob/landlock-v22/samples/landlock/sandboxer.c
__ https://github.com/landlock-lsm/linux/blob/landlock-v22/tools/testing/selftests/landlock/
__ linux-doc/landlock-v22/userspace-api/landlock.html


[PATCH v21] -- Landlock LSM
---------------------------

`LKML`__ -- `code`__ -- `sandbox manager example`__ -- `tests`__ -- `documentation`__

__ https://lore.kernel.org/lkml/20201008153103.1155388-1-mic@digikod.net/
__ https://github.com/landlock-lsm/linux/commits/landlock-v21
__ https://github.com/landlock-lsm/linux/blob/landlock-v21/samples/landlock/sandboxer.c
__ https://github.com/landlock-lsm/linux/blob/landlock-v21/tools/testing/selftests/landlock/
__ linux-doc/landlock-v21/security/landlock/index.html


[PATCH v20] -- Landlock LSM
---------------------------

`LKML`__ -- `code`__ -- `sandbox manager example`__ -- `tests`__ -- `documentation`__

__ https://lore.kernel.org/lkml/20200802215903.91936-1-mic@digikod.net/
__ https://github.com/landlock-lsm/linux/commits/landlock-v20
__ https://github.com/landlock-lsm/linux/blob/landlock-v20/samples/landlock/sandboxer.c
__ https://github.com/landlock-lsm/linux/blob/landlock-v20/tools/testing/selftests/landlock/
__ linux-doc/landlock-v20/security/landlock/index.html


[PATCH v19] -- Landlock LSM
---------------------------

`LKML`__ -- `code`__ -- `sandbox manager example`__ -- `tests`__ -- `documentation`__

__ https://lore.kernel.org/lkml/20200707180955.53024-1-mic@digikod.net/
__ https://github.com/landlock-lsm/linux/commits/landlock-v19
__ https://github.com/landlock-lsm/linux/blob/landlock-v19/samples/landlock/sandboxer.c
__ https://github.com/landlock-lsm/linux/blob/landlock-v19/tools/testing/selftests/landlock/
__ linux-doc/landlock-v19/security/landlock/index.html


[PATCH v18] -- Landlock LSM
---------------------------

`LKML`__ -- `code`__ -- `sandbox manager example`__ -- `tests`__ -- `documentation`__

__ https://lore.kernel.org/lkml/20200526205322.23465-1-mic@digikod.net/
__ https://github.com/landlock-lsm/linux/commits/landlock-v18
__ https://github.com/landlock-lsm/linux/blob/landlock-v18/samples/landlock/sandboxer.c
__ https://github.com/landlock-lsm/linux/blob/landlock-v18/tools/testing/selftests/landlock/
__ linux-doc/landlock-v18/security/landlock/index.html


[PATCH v17] -- Landlock LSM
---------------------------

`LKML`__ -- `code`__ -- `sandbox manager example`__ -- `tests`__ -- `documentation`__

__ https://lore.kernel.org/lkml/20200511192156.1618284-1-mic@digikod.net/
__ https://github.com/landlock-lsm/linux/commits/landlock-v17
__ https://github.com/landlock-lsm/linux/blob/landlock-v17/samples/landlock/sandboxer.c
__ https://github.com/landlock-lsm/linux/blob/landlock-v17/tools/testing/selftests/landlock/
__ linux-doc/landlock-v17/security/landlock/index.html


[PATCH v16] -- Landlock LSM
---------------------------

`LKML`__ -- `code`__ -- `sandbox manager example`__ -- `tests`__ -- `documentation`__

__ https://lore.kernel.org/lkml/20200416103955.145757-1-mic@digikod.net/
__ https://github.com/landlock-lsm/linux/commits/landlock-v16
__ https://github.com/landlock-lsm/linux/blob/landlock-v16/samples/landlock/sandboxer.c
__ https://github.com/landlock-lsm/linux/blob/landlock-v16/tools/testing/selftests/landlock/
__ linux-doc/landlock-v16/security/landlock/index.html


[PATCH v15] -- Landlock LSM
---------------------------

`LKML`__ -- `code`__ -- `sandbox manager example`__ -- `tests`__ -- `documentation`__

__ https://lore.kernel.org/lkml/20200326202731.693608-1-mic@digikod.net/
__ https://github.com/landlock-lsm/linux/commits/landlock-v15
__ https://github.com/landlock-lsm/linux/blob/landlock-v15/samples/landlock/sandboxer.c
__ https://github.com/landlock-lsm/linux/blob/landlock-v15/tools/testing/selftests/landlock/
__ linux-doc/landlock-v15/security/landlock/index.html


[PATCH v14] -- Landlock LSM
---------------------------

`LKML`__ -- `code`__ -- `sandbox manager example`__ -- `tests`__ -- `documentation`__

__ https://lore.kernel.org/lkml/20200224160215.4136-1-mic@digikod.net/
__ https://github.com/landlock-lsm/linux/commits/landlock-v14
__ https://github.com/landlock-lsm/linux/blob/landlock-v14/samples/landlock/sandboxer.c
__ https://github.com/landlock-lsm/linux/blob/landlock-v14/tools/testing/selftests/landlock/
__ linux-doc/landlock-v14/security/landlock/index.html


[PATCH v13] -- Landlock LSM
---------------------------

`LKML`__ -- `code`__ -- `ptrace tests`__ -- `documentation`__

__ https://lore.kernel.org/lkml/20191104172146.30797-1-mic@digikod.net/
__ https://github.com/landlock-lsm/linux/commits/landlock-v13
__ https://github.com/landlock-lsm/linux/blob/landlock-v13/tools/testing/selftests/landlock/test_ptrace.c
__ linux-doc/landlock-v13/security/landlock/index.html


[PATCH v12] -- Landlock LSM
---------------------------

`LKML`__ -- `code`__ -- `ptrace tests`__ -- `documentation`__

__ https://lore.kernel.org/lkml/20191031164445.29426-1-mic@digikod.net/
__ https://github.com/landlock-lsm/linux/commits/landlock-v12
__ https://github.com/landlock-lsm/linux/blob/landlock-v12/tools/testing/selftests/landlock/test_ptrace.c
__ linux-doc/landlock-v12/security/landlock/index.html


[PATCH v11] -- Landlock LSM
---------------------------

`LKML`__ -- `code`__ -- `ptrace tests`__ -- `documentation`__

__ https://lore.kernel.org/kernel-hardening/20191029171505.6650-1-mic@digikod.net/
__ https://github.com/landlock-lsm/linux/commits/landlock-v11
__ https://github.com/landlock-lsm/linux/blob/landlock-v11/tools/testing/selftests/landlock/test_ptrace.c
__ linux-doc/landlock-v11/security/landlock/index.html


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


[PATCH v9] -- Landlock LSM: toward unprivileged sandboxing
----------------------------------------------------------

`LKML`__ -- `code`__ -- `program example`__ -- `documentation`__

__ https://lore.kernel.org/linux-security-module/20190625215239.11136-1-mic@digikod.net/
__ https://github.com/landlock-lsm/linux/commits/landlock-v9
__ https://github.com/landlock-lsm/linux/blob/landlock-v9/samples/bpf/landlock1_kern.c
__ linux-doc/landlock-v9/security/landlock/index.html


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


External links
==============

Twitter__ -- GitHub__

__ https://twitter.com/l0kod
__ https://github.com/landlock-lsm
