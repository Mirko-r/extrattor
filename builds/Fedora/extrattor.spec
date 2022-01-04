Name:          extrattor
Version:       1.4
Release:       1%{?dist}
Summary:       Work with archives

License:       GPLv3+
URL:           https://github.com/Mirko-r/extrattor
Source0:       extrattor.sh
BuildArch:     noarch

Requires:      unarj
Requires:      unace
Requires:      p7zip
Requires:      tar
Requires:      pax
Requires:      gzip
Requires:      unzip
Requires:      xz
Requires:      bash
BuildRequires: wget

%description
A simple bash wrapper to manage one or more archives from the terminal

%prep
wget https://github.com/Mirko-r/extrattor/releases/download/%{version}/extrattor.sh

%install
mkdir -p %{buildroot}%{_bindir}
install -p -m 755 %{SOURCE0} %{buildroot}%{_bindir}

%files
%{_bindir}/extrattor.sh

%changelog
