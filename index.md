# Landlock: unprivileged access control

```{toctree}
:maxdepth: 1
:hidden:
🏠 Overview <self>
📰 News <news.md>
🎤 Talks <talks.md>
🌱 Genesis <genesis.md>
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

## Roadmap (kernel-side)

See [Landlock tasks on GitHub](https://github.com/orgs/landlock-lsm/projects/1).

[Kernel development](https://docs.kernel.org/process/submitting-patches.html) still happens on the related mailing lists though.

# External links

[Mastodon](https://mastodon.social/@l0kod) -- [Twitter](https://twitter.com/l0kod) -- [GitHub](https://github.com/landlock-lsm)
