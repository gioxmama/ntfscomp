Name:           ntfscomp
Version:        1.0.0
Release:        1%{?dist}
Summary:        NTFS-compliant file/folder renamer

License:        MIT
URL:            https://github.com/gioxmama/ntfscomp
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch

%description
A command-line utility that recursively renames files and folders to be NTFS-compliant and compatible with Windows. It replaces forbidden characters, trims trailing spaces and dots, and optionally truncates names.

%prep
%setup -q

%build
# No build steps needed for bash scripts

%install
mkdir -p buildroot/ntfscomp-1.0.0
cp scripts/ntfscomp.sh buildroot/ntfscomp-1.0.0/
tar czf rpmbuild/SOURCES/ntfscomp-1.0.0.tar.gz -C buildroot ntfscomp-1.0.0

%files
/usr/bin/ntfscomp

%post
echo "ntfscomp installed. You can run it with the command: ntfscomp"

%changelog
* Tue Sep 02 2025 gioxmama <114627085+gioxmama@users.noreply.github.com> - 1.0.0-1
- Initial