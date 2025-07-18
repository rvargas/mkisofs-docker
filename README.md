# mkisofs-docker

A lightweight Docker container for creating ISO 9660 filesystem images using `mkisofs` from the cdrkit package.

## Quick Start

### Pull and run the container

```bash
# Show help and available options
docker run --rm rvargas/mkisofs-docker

# Create an ISO from files in current directory
docker run --rm -v $(pwd):/data rvargas/mkisofs-docker \
  -o output.iso -V "My Volume" .
```

### Build locally

```bash
git clone https://github.com/rvargas/mkisofs-docker.git
cd mkisofs-docker
docker build -t mkisofs-docker .
```

## Usage Examples

### Basic ISO creation

Create an ISO from files in the current directory:

```bash
docker run --rm -v $(pwd):/data mkisofs-docker \
  -o myfiles.iso -V "MyFiles" .
```

### Advanced options

Create a bootable ISO with specific volume label and system identifier:

```bash
docker run --rm -v $(pwd):/data mkisofs-docker \
  -o bootable.iso \
  -V "BOOT_DISK" \
  -A "My Application" \
  -sysid "LINUX" \
  -b isolinux/isolinux.bin \
  -c isolinux/boot.cat \
  -no-emul-boot \
  -boot-load-size 4 \
  -boot-info-table \
  .
```

### Mount specific directories

Process files from a specific directory:

```bash
docker run --rm -v /path/to/source:/data mkisofs-docker \
  -o output.iso -V "SOURCE_FILES" .
```

### Output to mounted volume

Save the ISO to a specific location:

```bash
docker run --rm \
  -v $(pwd)/source:/data \
  -v $(pwd)/output:/output \
  mkisofs-docker \
  -o /output/result.iso -V "RESULT" /data
```

## Common mkisofs Options

| Option | Description |
|--------|-------------|
| `-o file` | Output ISO file |
| `-V volid` | Volume ID (up to 32 characters) |
| `-A appid` | Application identifier |
| `-sysid id` | System identifier |
| `-b bootimg` | Boot image for El Torito |
| `-c bootcat` | Boot catalog for El Torito |
| `-no-emul-boot` | No boot emulation |
| `-J` | Generate Joliet directory records |
| `-R` | Generate Rock Ridge directory information |
| `-l` | Allow full 31 character filenames |

## Container Details

- **Base image**: Alpine Linux 3.20
- **Package**: cdrkit (provides mkisofs)
- **Working directory**: `/data`
- **Entrypoint**: `mkisofs`
- **Default command**: `--help`

## Building and Development

### Prerequisites

- Docker installed and running
- Git (for cloning the repository)

### Local build

```bash
git clone https://github.com/rvargas/mkisofs-docker.git
cd mkisofs-docker
docker build -t mkisofs-docker .
```

### Testing

Test the container with a simple ISO creation:

```bash
# Create a test directory with some files
mkdir test-files
echo "Hello World" > test-files/hello.txt
echo "Test content" > test-files/test.txt

# Create ISO
docker run --rm -v $(pwd)/test-files:/data mkisofs-docker \
  -o test.iso -V "TEST" .

# Verify ISO was created
ls -la test.iso
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [cdrkit](http://cdrkit.org/) - The CD/DVD/BD recording toolkit
- [Alpine Linux](https://alpinelinux.org/) - Security-oriented, lightweight Linux distribution 