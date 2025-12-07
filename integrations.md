# Integrations

This page provides non-exhaustive lists of open-source projects that have integrated Landlock sandboxing support.
These lists are provided for informational purposes to highlight potentially interesting projects using Landlock, but we have not audited their code.

## Sandboxed projects

```{list-table}
:header-rows: 1

* - Project
  - Type
  - Source
  - Notes

* - [bevy_mod_lockdown](https://github.com/FrTerstappen/bevy_mod_lockdown)
  - Sandbox library
  - GitHub repository
  - Sandbox library for Bevy game engine

* - [Cloud Hypervisor](https://github.com/cloud-hypervisor/cloud-hypervisor)
  - VM monitor
  - Merged [GitHub PR](https://github.com/cloud-hypervisor/cloud-hypervisor/pull/6214)
  - Virtual machine monitor

* - [Codex CLI](https://github.com/openai/codex)
  - AI agent
  - Merged [GitHub PR](https://github.com/openai/codex/pull/629)
  - OpenAI's CLI agent

* - [Crazy traceroute](https://codeberg.org/mark22k/crazytrace)
  - Network tool
  - Merged [Codeberg commit](https://codeberg.org/mark22k/crazytrace/commit/351937f2fee5855648aa1446c05e19df4d9bb68a)
  - Network simulation program

* - [Pledge for Linux](https://github.com/jart/cosmopolitan/blob/master/libc/calls/unveil.c)
  - Sandbox library
  - [Blog post](https://justine.lol/pledge/)
  - Pledge and Unveil implementation for Linux using Landlock and the Cosmopolitan libc

* - [dosemu2](https://github.com/dosemu2/dosemu2)
  - Emulator
  - Merged [GitHub PR](https://github.com/dosemu2/dosemu2/pull/2344)
  - DOS emulator for Linux

* - [egress-eddie](https://github.com/capnspacehook/egress-eddie)
  - Network tool
  - [Released](https://github.com/capnspacehook/egress-eddie/releases/tag/v0.5.0)
  - Network filtering tool (support since v0.5.0)

* - [Emilua](https://docs.emilua.org)
  - Lua runtime
  - Upstream [Documentation](https://docs.emilua.org/api/0.5/changelog.html)
  - Lua runtime with Landlock support (since v0.5)

* - [exile.h](https://github.com/quitesimpleorg/exile.h)
  - Sandbox library
  - GitHub repository
  - Header-only sandboxing library

* - [extrasafe](https://github.com/boustrophedon/extrasafe)
  - Sandbox library
  - Merged [GitHub PR](https://github.com/boustrophedon/extrasafe/pull/28)
  - Rust sandbox library (v0.4.0+)

* - [landlock-sharp](https://www.nuget.org/packages/Landlock)
  - Sandbox library
  - [GitHub repository](https://github.com/curiosity-ai/landlock-sharp/)
  - C# sandbox library (v25.12.63045+)

* - [Firejail](https://github.com/netblue30/firejail)
  - Sandboxer
  - Merged [GitHub PR](https://github.com/netblue30/firejail/pull/6078)
  - SUID sandbox program (v0.9.74+)

* - [Game of Trees](https://gameoftrees.org)
  - Development tool
  - Upstream [code](https://git.gameoftrees.org/gitweb/?p=got-portable.git;a=blob;f=compat/landlock.c)
  - Version control system

* - [Gemini CLI](https://github.com/google-gemini/gemini-cli)
  - AI agent
  - Open [GitHub PR](https://github.com/google-gemini/gemini-cli/pull/13481)
  - Google's AI agent

* - [Go Landlock](https://github.com/landlock-lsm/go-landlock)
  - Sandbox library
  - GitHub repository
  - Official Go library for Landlock, see [documentation](https://pkg.go.dev/github.com/landlock-lsm/go-landlock/landlock)

* - [Haskell Landlock](https://hackage.haskell.org/package/landlock)
  - Sandbox library
  - [GitHub repository](https://github.com/NicolasT/landlock-hs)
  - Haskell bindings for Landlock

* - [Nomad exec2](https://github.com/hashicorp/nomad-driver-exec2)
  - Orchestrator
  - Upstream [documentation](https://developer.hashicorp.com/nomad/plugins/drivers/exec2)
  - HashiCorp workload orchestrator

* - [Keysas](https://github.com/r3dlight/keysas)
  - Security tool
  - GitHub repository
  - USB malware cleaning station

* - [Landlock Config](https://github.com/landlock-lsm/landlockconfig)
  - Sandbox library
  - GitHub repository
  - Official Landlock configuration format and library

* - [Landlock Make](https://github.com/jart/landlock-make)
  - Development tool
  - [Blog post](https://justine.lol/make/)
  - Zero-configuration sandboxing for hermetic builds

* - [Landrun](https://github.com/Zouuup/landrun)
  - Sandboxer
  - GitHub repository
  - Sandboxing tool leveraging Landlock

* - [Minijail](https://chromium.googlesource.com/chromiumos/platform/minijail)
  - Sandboxer
  - Upstream [code](https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/minijail/libminijail.c)
  - ChromeOS sandbox manager and library

* - [OCI Runtime Spec](https://github.com/opencontainers/runtime-spec)
  - Specification
  - Open [GitHub PR](https://github.com/opencontainers/runtime-spec/pull/1111)
  - Open Container Initiative runtime specification

* - [p7zip](https://github.com/p7zip-project/p7zip)
  - Archive manager
  - Open [GitHub PR](https://github.com/p7zip-project/p7zip/pull/184)
  - Archive manager ([forked](https://sourceforge.net/projects/p7zip/))

* - [Pacman](https://archlinux.org/pacman/)
  - Package manager
  - Merged [GitLab MR](https://gitlab.archlinux.org/pacman/pacman/-/merge_requests/167)
  - Arch Linux package manager (support since v7.0.0)

* - [PAM](https://github.com/linux-pam/linux-pam)
  - Authentication
  - Open [GitHub PR](https://github.com/linux-pam/linux-pam/pull/486)
  - Pluggable Authentication Modules

* - [Polkadot](https://polkadot.com/)
  - Blockchain
  - Merged [GitHub PR](https://github.com/paritytech/polkadot/pull/7303)
  - Blockchain SDK

* - [runc](https://github.com/opencontainers/runc)
  - Container runtime
  - Open [GitHub PR](https://github.com/opencontainers/runc/pull/3194)
  - OCI container runtime

* - [Rust Landlock](https://github.com/landlock-lsm/rust-landlock)
  - Sandbox library
  - GitHub repository
  - Official Rust library for Landlock, see [documentation](https://landlock.io/rust-landlock/landlock/)

* - [rust-wasm-landlock](https://github.com/micheleberetta98/rust-wasm-landlock)
  - WebAssembly runtime
  - GitHub repository
  - WebAssembly runtime with Landlock support

* - [setpriv](https://github.com/util-linux/util-linux)
  - Sandboxer
  - Merged [GitHub PR](https://github.com/util-linux/util-linux/pull/2628)
  - Utility to run programs with different privileges (support since util-linux v2.40)

* - [snapd](https://github.com/canonical/snapd)
  - Package manager
  - Merged [GitHub PR](https://github.com/canonical/snapd/pull/15928)
  - Package manager (support since v2.72)

* - [sslh](https://github.com/yrutschle/sslh)
  - Network service
  - Merged [release](https://github.com/yrutschle/sslh/releases/tag/v2.1.0)
  - Applicative protocol multiplexer (v2.1.0+)

* - [strace](https://strace.io)
  - Developer tool
  - Merged [commit](https://github.com/strace/strace/commit/7592a0eeab2588162c1741077053f8a052c8418f)
  - System call tracer with Landlock syscall support (v5.13+)

* - [Suricata](https://suricata.io)
  - Network service
  - Merged [GitHub PR](https://github.com/OISF/suricata/pull/7853), see [documentation](https://docs.suricata.io/en/latest/configuration/landlock.html)
  - Network security monitoring engine (support since v7.0.0)

* - [systemd](https://systemd.io/)
  - Service manager
  - Open [GitHub PR](https://github.com/systemd/systemd/pull/39174)
  - System and service manager

* - [tracker-extract](https://gitlab.gnome.org/GNOME/localsearch)
  - Desktop service
  - Merged [GitLab MR](https://gitlab.gnome.org/GNOME/localsearch/-/merge_requests/499)
  - GNOME metadata extraction service (GNOME 46+)

* - [Ukuleleweb](https://github.com/gnoack/ukuleleweb)
  - Network service
  - Merged [GitHub commit](https://github.com/gnoack/ukuleleweb/commit/0ecdd54b36fa)
  - Lightweight wiki server

* - [Unblob](https://unblob.org)
  - Archive manager
  - Merged [GitHub PR](https://github.com/onekey-sec/unblob/pull/597)
  - Extraction tool for firmware and file systems (support since v24.12.4)

* - [Warpinator](https://github.com/linuxmint/warpinator)
  - Network service
  - Merged [GitHub PR](https://github.com/linuxmint/warpinator/pull/160)
  - LAN file transfer tool with Landlock isolation

* - [websrv](https://github.com/ngergs/websrv)
  - Network service
  - Merged [GitHub commit](https://github.com/ngergs/websrv/commit/40fa2d7d2bbb)
  - Web server in Go (support since v3.2.0)

* - [wireproxy](https://github.com/pufferffish/wireproxy)
  - Network client
  - Merged [GitHub PR](https://github.com/pufferffish/wireproxy/pull/108)
  - Wireguard client (support since 1.0.8)

* - [XZ Utils](https://github.com/tukaani-project/xz)
  - Archive manager
  - Merged [GitHub commit](https://github.com/tukaani-project/xz/commit/8276c7f41c671eee4aa3239490658b23dcfd3021)
  - Archive manager and compression library (support since v5.6.0), also see the [backdoor incident](https://research.swtch.com/xz-timeline))

* - [Zathura](https://pwmt.org/projects/zathura/)
  - Document viewer
  - Merged [GitHub PR](https://github.com/pwmt/zathura/pull/575)
  - Document viewer (work in progress)
```


## Examples and proof of concepts


```{list-table}
:header-rows: 1

* - Project
  - Type
  - Source
  - Notes

* - [ImageMagick](https://imagemagick.org)
  - Graphics
  - Example [workshop](https://github.com/landlock-lsm/workshop-imagemagick)
  - Example of sandboxing ImageMagick

* - [lighttpd](https://www.lighttpd.net)
  - Network service
  - Example [tutorial](https://github.com/landlock-lsm/tuto-lighttpd)
  - Lightweight web server with sandboxing tutorial

* - [sandboxer](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/landlock/sandboxer.c)
  - Sandboxer
  - Sample from the [Linux kernel](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/landlock/sandboxer.c)
  - Official Landlock example in C
```

## Linux distributions

The following Linux distributions have Landlock enabled in their kernel configuration.

```{list-table}
:header-rows: 1

* - Distribution
  - Status
  - Source

* - [Alpine Linux](https://alpinelinux.org/)
  - Enabled by default
  - Merged [commit](https://gitlab.alpinelinux.org/alpine/aports/-/commit/b49410ac39b3c9ef46434b9d5daa79f2c845015e)

* - [Arch Linux](https://archlinux.org/)
  - Enabled by default
  - Merged [commit](https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/commit/25898768185889a13f3e7a6fa47fcb831ba5b661) (5.13.1.arch1-1)

* - [Azure Linux](https://github.com/microsoft/azurelinux)
  - Enabled by default
  - Merged [GitHub PR](https://github.com/microsoft/azurelinux/pull/3484) (formerly called CBL-Mariner)

* - [CentOS Stream](https://www.centos.org/centos-stream/)
  - Enabled by default
  - Same as RHEL

* - [ChromeOS](https://www.chromium.org/chromium-os/)
  - Enabled by default
  - Merged [CL](https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3710348) (Linux 5.10) and [CL](https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3552261) (Linux 5.15)

* - [ChromeOS (Termina VM)](https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/vm_tools/)
  - Enabled by default
  - Merged [CL](https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3934954)

* - [Debian](https://www.debian.org/releases/sid/)
  - Enabled by default
  - Merged [commit](https://salsa.debian.org/kernel-team/linux/-/commit/66232ef71227b1f1e502d1ca8a96ef898762176e) and [commit](https://salsa.debian.org/kernel-team/linux/-/commit/1ef40f40e593a5dc223e9ce171fa8f2cd5aba198) (Debian Sid since kernel 5.18.16-1)

* - [Fedora](https://fedoraproject.org/)
  - Enabled by default
  - Merged [commit](https://gitlab.com/cki-project/kernel-ark/-/commit/6970e5d6cb60a5eef2443cc0683c58a5d4531639) (since Fedora 35)

* - [Flatcar](https://www.flatcar.org/)
  - Enabled by default
  - Merged [GitHub PR](https://github.com/flatcar/scripts/pull/2158)

* - [Gentoo](https://www.gentoo.org/)
  - Enabled wrt kernel variant
  - Merged [commit](https://gitweb.gentoo.org/proj/linux-patches.git/commit/?id=27a3d3432243c1bd89ef3c68330f8d31da45ba34)

* - [GNOME OS](https://os.gnome.org/)
  - Enabled by default
  - Merged [GitLab MR](https://gitlab.gnome.org/GNOME/gnome-build-meta/-/merge_requests/2559)

* - [Red Hat Enterprise Linux (RHEL)](https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux)
  - Enabled by default
  - Merged [GitLab MR](https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/5490) (since RHEL 9.6.0, backported features up to ABI 5: [kernel-5.14.0-568.el9](https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/commit/5ba435c29b4704e87af1a0fd291ea6610ff5af92))

* - [Rocky Linux](https://rockylinux.org/)
  - Enabled by default
  - [Bug report](https://bugs.rockylinux.org/view.php?id=7987)

* - [OpenSUSE](https://www.opensuse.org/)
  - Enabled by default
  - Merged [commit](https://github.com/openSUSE/kernel-source/commit/b74aeb04cd428f4a3349c463933b21a503b5002f) (since kernel 5.13-rc1)

* - [Ubuntu](https://ubuntu.com/)
  - Enabled by default
  - Merged [commit](https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/commit/?id=dd51cf78272d9e36270796a563c801d251d7f06c) (since 20.04 LTS)

* - [Windows Subsystem for Linux 2 (WSL)](https://learn.microsoft.com/en-us/windows/wsl/)
  - Enabled by default
  - [Released](https://github.com/microsoft/WSL2-Linux-Kernel/releases/tag/linux-msft-wsl-5.15.57.1)
```
