# Landlock: Unprivileged Sandboxing

```{toctree}
:maxdepth: 1
:hidden:
🏠 Overview <self>
📰 News <news.md>
🗺️ Roadmap <https://github.com/orgs/landlock-lsm/projects/1>
🎤 Talks <talks.md>
📄 Documentation <https://docs.kernel.org/userspace-api/landlock.html>
📦 Integrations <integrations.md>
🏝️ Island (sandboxing tool) <https://github.com/landlock-lsm/island>
🌱 Genesis <genesis.md>
🦀 Rust <https://crates.io/crates/landlock>
🐹 Go <https://pkg.go.dev/github.com/landlock-lsm/go-landlock/landlock>
🦣 Mastodon <https://mastodon.social/@l0kod>
🐙 GitHub <https://github.com/landlock-lsm>
```

The goal of Landlock is to enable restricting ambient rights (e.g. global
filesystem access) for a set of processes. Because Landlock is a stackable
LSM, it makes it possible to create safe security sandboxes as new security layers
in addition to the existing system-wide access controls. This kind of sandbox
is expected to help mitigate the security impact of bugs or
unexpected/malicious behaviors in user space applications. Landlock empowers
any process, including unprivileged ones, to securely restrict themselves.

## Resources

Main resources are available through the left panel.

Additional resources:
- Article [Landlock: From a security mechanism idea to a widely available implementation](talks/2024-06-06_landlock-article.pdf)
- [Sandbox manager example (in C)](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/landlock/sandboxer.c)
- [Kernel code](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/landlock)
- [Tests](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/landlock) and [syzkaller coverage](https://syzkaller.appspot.com/upstream)
- [Landlock logo](https://github.com/landlock-lsm/landlock-logo)

## Contribute

Kernel development happens on the [Linux Security Modules mailing list](https://lore.kernel.org/linux-security-module/)
by [submitting patches](https://docs.kernel.org/process/submitting-patches.html).

User space news is on the [Landlock mailing list](https://lore.kernel.org/landlock/).
You can [subscribe](mailto:landlock+subscribe@lists.linux.dev) and
[post](mailto:landlock@lists.linux.dev) with any email client.
