# Landlock: unprivileged access control

```{toctree}
:caption: 'Contents:'
:maxdepth: 2
```

The goal of Landlock is to enable to restrict ambient rights (e.g. global
filesystem access) for a set of processes.  Because Landlock is a stackable
LSM, it makes possible to create safe security sandboxes as new security layers
in addition to the existing system-wide access-controls. This kind of sandbox
is expected to help mitigate the security impact of bugs or
unexpected/malicious behaviors in user space applications.  Landlock empowers
any process, including unprivileged ones, to securely restrict themselves.

[Mailing list](https://subspace.kernel.org/lists.linux.dev.html) dedicated to user space development involving Landlock: [subscription](mailto:landlock+subscribe@lists.linux.dev), [posting](mailto:landlock@lists.linux.dev) and [archives](https://lore.kernel.org/landlock/).

## Resources

- [Landlock documentation](https://docs.kernel.org/userspace-api/landlock.html) and [article](talks/2024-06-06_landlock-article.pdf)
- [Rust](https://crates.io/crates/landlock) and [Go](https://pkg.go.dev/github.com/landlock-lsm/go-landlock/landlock) libraries
- [sandbox manager example (in C)](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/landlock/sandboxer.c)
- [kernel code](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/landlock), [tests](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/landlock), and [syzkaller coverage](https://syzkaller.appspot.com/upstream)
- [Landlock logo](https://github.com/landlock-lsm/landlock-logo)

## News

- Newsletter (2025-05-19) - [Landlock news #5](https://lore.kernel.org/landlock/20250519.ceihohf6a3uT@digikod.net/)
- Linux 6.15 (TBD) - [Add audit support](https://git.kernel.org/torvalds/c/72885116069abdd05c245707c3989fc605632970)
- Linux 6.12 (2024-11-17) - [New LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET and LANDLOCK_SCOPE_SIGNAL](https://git.kernel.org/torvalds/c/e1b061b444fb01c237838f0d8238653afe6a8094)
- Linux 6.10 (2024-07-24) - [New LANDLOCK_ACCESS_FS_IOCTL_DEV](https://git.kernel.org/torvalds/c/2fc0e7892c10734c1b7c613ef04836d57d4676d5)
- Newsletter (2024-07-16) - [Landlock news #4](https://lore.kernel.org/landlock/20240716.yui4Iezai8ae@digikod.net/)
- Linux 6.9 (2024-05-12) - [Add support for KUnit and extend documentation](https://git.kernel.org/torvalds/c/35e886e88c803920644c9d3abb45a9ecb7f1e761)
- Linux 6.7 (2024-01-27) - [New LANDLOCK_ACCESS_NET_BIND_TCP and LANDLOCK_ACCESS_NET_CONNECT_TCP](https://git.kernel.org/torvalds/c/136cc1e1f5be75f57f1e0404b94ee1c8792cb07d)
- Linux 6.5 (2023-08-27) - [Add support to the UML architecture](https://git.kernel.org/torvalds/c/26642864f8b212964f80fbd69685eb850ced5f45)
- Newsletter (2023-03-22) - [Landlock news #3](https://lore.kernel.org/landlock/d4ed5733-d07b-5548-2534-a63e22906778@digikod.net/)
- Linux 6.2 (2023-02-19) - [New LANDLOCK_ACCESS_FS_TRUNCATE](https://git.kernel.org/torvalds/c/299e2b1967578b1442128ba8b3e86ed3427d3651)
- Newsletter (2022-08-17) - [Landlock news #2](https://lore.kernel.org/landlock/441bd1cd-03fd-8e30-c370-3d0f0263d564@digikod.net/)
- Linux 5.19 (2022-07-31) - [New LANDLOCK_ACCESS_FS_REFER, improved documentation and 16 layers limit](https://git.kernel.org/torvalds/c/cb44e4f061e16be65b8a16505e121490c66d30d0)
- Newsletter (2021-09-01) - [Landlock news #1](https://lore.kernel.org/landlock/2df4887a-1710-bba2-f49c-cd5b785bb565@digikod.net/)
- Linux 5.13 (2021-06-27) - [Initial Landlock version](https://git.kernel.org/torvalds/c/17ae69aba89dbfa2139b7f8024b757ab3cc42f59)
- LWN article (2021-06-17) - [Landlock (finally) sets sail](https://lwn.net/Articles/859908/)

## Conferences

- FOSDEM (2025-02-01) - [Sandbox IDs with Landlock](https://fosdem.org/2025/schedule/event/fosdem-2025-6071-sandbox-ids-with-landlock/) -- [slides](talks/2025-02-01_landlock-fosdem.pdf) and [recording](https://video.fosdem.org/2025/ud2218a/fosdem-2025-6071-sandbox-ids-with-landlock.av1.webm)
- Class and workshop (2025-01-29) [Landlock overview and workshop](talks/2025-01-29_landlock-workshop.pdf)
- Open Source Summit (2024-09-17) - [Linux sandboxing with Landlock](https://sched.co/1ej3a) -- [slides](talks/2024-09-17_landlock-oss.pdf) and [recording](https://youtu.be/d85TDpv8L9U)
- Linux Security Summit (2024-09-17) - [Update on Landlock: IOCTL Support](https://sched.co/1ebVW) -- [slides](talks/2024-09-17_landlock-lss.pdf) and [recording](https://youtu.be/yCHGmdXpylA?t=4253s)
- Pass the Salt (2024-07-03) - [Landlock workshop: Linux sandboxing in practice](https://cfp.pass-the-salt.org/pts2024/talk/8FVYDF/) -- [slides](talks/2024-07-03_landlock-pts-workshop.pdf)
- SSTIC (2024-06-06) - [Landlock: From a security mechanism idea to a widely available implementation](https://www.sstic.org/2024/presentation/landlock-design/) -- [article](talks/2024-06-06_landlock-article.pdf) and [slides](talks/2024-06-06_landlock-design.pdf)
- Class and workshop (2024-01-22) [Landlock overview](talks/2024-01-22_landlock-overview.pdf) and [Landlock workshop](talks/2024-01-22_landlock-workshop.pdf)
- Kernel Recipes (2023-09-25) - [Update on Landlock: Audit, Debugging and Metrics](https://kernel-recipes.org/en/2023/update-on-landlock-audit-debugging-and-metrics/) -- [slides](talks/2023-09-25_landlock-audit-kr.pdf)
- Linux Security Summit Europe (2023-09-21) - [Landlock Workshop: Sandboxing Application for Fun and Protection](https://sched.co/1OLAi) -- [slides](talks/2023-09-21_landlock-imagemagick-lss-eu.pdf)
- Linux Security Summit Europe (2023-09-21) - [Update on Landlock: Audit, Debugging and Metrics](https://sched.co/1OL79) -- [slides](talks/2023-09-21_landlock-audit-lss-eu.pdf)
- FOSDEM (2023-02-04) - [Backward and forward compatibility for security features (illustrated with Landlock)](https://fosdem.org/2023/schedule/event/rust_backward_and_forward_compatibility_for_security_features/) -- [slides](talks/2023-02-04_rust-landlock-fosdem.pdf)
- Netdev 0x16 (2022-10-24) - [How to sandbox a network application with Landlock](https://netdevconf.info/0x16/session.html?How-to-sandbox-a-network-application-with-Landlock) -- [slides](talks/2022-10-24_landlock-netdevconf.pdf) and [tutorial files](https://github.com/landlock-lsm/tuto-lighttpd)
- Pass the Salt (2022-07-04) - [Sandboxing your application with Landlock, illustration with the p7zip case](https://cfp.pass-the-salt.org/pts2022/talk/BGQGZC/) -- [slides](talks/2022-07-04_landlock-pts.pdf) and [recording](https://passthesalt.ubicast.tv/videos/sandboxing-your-application-with-landlock-illustration-with-the-p7zip-case/)
- Linux Security Summit North America (2022-06-24) - [Update on Landlock: Lifting the File Reparenting Limits and Supporting Network Rules](https://sched.co/11MXq) -- [slides](talks/2022-06-24_landlock-lss-na.pdf) and [recording](https://youtu.be/MWjW-QwK_ZA)
- Linux Security Summit (2021-09-29) - [Deep Dive into Landlock Internals](https://sched.co/ljRQ) -- [slides](talks/2021-09-29_landlock-lss.pdf) and [recording](https://youtu.be/5Al2z0LTEMs)
- Open Source Summit (2021-09-28) - [Sandboxing Applications with Landlock](https://sched.co/lAVl) -- [slides](talks/2021-09-28_landlock-oss.pdf) and [recording](https://youtu.be/ohoofZ62O98)

## Roadmap (kernel-side)

See [Landlock tasks on GitHub](https://github.com/orgs/landlock-lsm/projects/1).

[Kernel development](https://docs.kernel.org/process/submitting-patches.html) still happens on the related mailing lists though.

# External links

[Mastodon](https://mastodon.social/@l0kod) -- [Twitter](https://twitter.com/l0kod) -- [GitHub](https://github.com/landlock-lsm)

# Archives

```{warning}
Landlock is not based on eBPF anymore.  These talks are outdated but kept for reference.
```

## Summary 2019 -- Landlock: a new kind of Linux Security Module leveraging eBPF

[Slides](talks/2019-09-12_landlock-summary.pdf)

## Linux Security Summit 2018 -- How to safely restrict access to files in a programmatic way with Landlock?

[Abstract](https://lssna18.sched.com/event/FLYR) -- [Slides](talks/2018-08-27_landlock-lss.pdf) -- [Demo video #1 (web server)](talks/2018-08-27_landlock-lss_demo-1-web.mkv) -- [Demo video #2 (dynamic map update)](talks/2018-08-27_landlock-lss_demo-2-dynmap.mkv) -- [Demo code](https://github.com/landlock-lsm/linux/blob/landlock-v8/samples/bpf/landlock1_kern.c)

## Pass the SALT 2018 -- Internals of Landlock: a new kind of Linux Security Module leveraging eBPF

[Abstract and video](https://2018.pass-the-salt.org/programme/#landlock) -- [Slides](talks/2018-07-04_landlock-pts.pdf) -- [Demo video #1 (web server)](talks/2018-07-04_landlock-pts_demo-1-web.mkv) -- [Demo video #2 (dynamic map update)](talks/2018-07-04_landlock-pts_demo-2-dynmap.mkv) -- [Demo code](https://github.com/landlock-lsm/linux/blob/landlock-v8/samples/bpf/landlock1_kern.c)

## FOSDEM 2018 -- File access-control per container with Landlock

[Abstract and video](https://fosdem.org/2018/schedule/event/containers_landlock/) -- [Slides](talks/2018-02-04_landlock-fosdem.pdf) -- [Demo video](talks/2018-02-04_landlock-fosdem_demo.mkv) -- [Demo code](https://github.com/landlock-lsm/linux/blob/landlock-v8-alpha/samples/bpf/landlock1_kern.c)

## Linux Security Summit 2017 -- Landlock LSM: toward unprivileged sandboxing

[Slides](talks/2017-09-14_landlock-lss.pdf) -- [Demo #1](talks/2017-09-14_landlock-lss_demo-1-ro-tty.mkv) -- [Demo #2](talks/2017-09-14_landlock-lss_demo-2-fsview-gui.mkv)
