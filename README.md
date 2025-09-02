# ntfscomp

A command-line utility written in Bash that recursively renames files and folders to be NTFS-compliant and compatible with Windows. It sanitizes names by replacing forbidden characters, trimming trailing spaces and dots, and optionally truncating names to a specified maximum length.

## 🚀 Features

- Recursively scans a target folder and its subdirectories
- Replaces forbidden NTFS characters (`< > : " / \ | ? *`) with underscores
- Trims trailing spaces and dots
- Supports dry-run mode for safe simulation
- Allows setting a maximum name length (default: 255)
- Optional logging of all operations
- Packaged as `.deb` and `.rpm` for easy installation

## 📦 Installation

### Debian/Ubuntu (.deb)

```sh
sudo dpkg -i ntfscomp_<version>.deb
```

### Fedora/RHEL (.rpm)

```sh
sudo rpm -i ntfscomp-<version>.rpm
```

Or build from source:

```sh
git clone https://github.com/youruser/ntfscomp.git
cd ntfscomp/scripts
chmod +x ntfscomp.sh
```

## 🛠 Usage

```sh
./ntfscomp.sh --folder /path/to/target
```

### Options

- `-f, --folder` &nbsp;&nbsp;&nbsp;&nbsp; Path to the target folder (required)
- `-d, --dry-run` &nbsp;&nbsp;&nbsp;&nbsp; Simulate renaming without making changes
- `-L, --length` &nbsp;&nbsp;&nbsp;&nbsp; Maximum name length (default: 255)
- `-l, --log` &nbsp;&nbsp;&nbsp;&nbsp; Enable logging (saved to `$HOME/rename_log.txt`)
- `--help` &nbsp;&nbsp;&nbsp;&nbsp; Show help message

### Example

```sh
./ntfscomp.sh --folder ~/Downloads --dry-run --log
```

## 📝 Logging

If logging is enabled (`--log`), all rename operations are saved to `$HOME/rename_log.txt`.

## ⚠️ Notes

- Only files and folders with names requiring changes are renamed.
- Dry-run mode does not modify any files.
- The script does not overwrite existing files; it skips renames if the target name already exists.

## 📄 License

MIT License

## 🤝 Contributing

Pull requests and issues are welcome!

## 💡 Author