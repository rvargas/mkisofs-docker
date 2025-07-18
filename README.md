# mkisofs-docker

[![Docker Hub](https://img.shields.io/docker/pulls/rvargas/mkisofs-docker)](https://hub.docker.com/r/rvargas/mkisofs-docker)
[![Docker Image Size](https://img.shields.io/docker/image-size/rvargas/mkisofs-docker/1.1.0)](https://hub.docker.com/r/rvargas/mkisofs-docker)

A lightweight Docker container for creating ISO 9660 filesystem images with `mkisofs` compatibility, powered by the modern `xorriso` implementation.

## Quick Start

### Using the pre-built image (recommended)

```bash
# Pull the image (optional - Docker will pull automatically if not present)
docker pull rvargas/mkisofs-docker:1.1.0

# Show help and available options
docker run --rm rvargas/mkisofs-docker:1.1.0

# Create an ISO from files in current directory
docker run --rm -v $(pwd):/data rvargas/mkisofs-docker:1.1.0 \
  -o output.iso -V "My Volume" .
```

### Building from source (for development)

Only needed if you want to modify the container or contribute to the project:

```bash
git clone https://github.com/rvargas/mkisofs-docker.git
cd mkisofs-docker
docker build -t rvargas/mkisofs-docker:1.1.0 .
```

## Usage Examples

### Basic ISO creation

Create an ISO from files in the current directory:

```bash
docker run --rm -v $(pwd):/data rvargas/mkisofs-docker:1.1.0 \
  -o myfiles.iso -V "MyFiles" .
```

### Advanced options

Create a bootable ISO with specific volume label and system identifier:

```bash
docker run --rm -v $(pwd):/data rvargas/mkisofs-docker:1.1.0 \
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
docker run --rm -v /path/to/source:/data rvargas/mkisofs-docker:1.1.0 \
  -o output.iso -V "SOURCE_FILES" .
```

### Output to mounted volume

Save the ISO to a specific location:

```bash
docker run --rm \
  -v $(pwd)/source:/data \
  -v $(pwd)/output:/output \
  rvargas/mkisofs-docker:1.1.0 \
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
- **Packages**: cdrkit, xorriso
- **Implementation**: `xorriso -as mkisofs` (mkisofs compatibility mode)
- **Working directory**: `/data`
- **Entrypoint**: `["xorriso", "-as", "mkisofs"]`
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
docker run --rm -v $(pwd)/test-files:/data rvargas/mkisofs-docker:1.1.0 \
  -o test.iso -V "TEST" .

# Verify ISO was created
ls -la test.iso
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [xorriso](https://www.gnu.org/software/xorriso/) - GNU xorriso, modern ISO 9660 Rock Ridge filesystem manipulator
- [cdrkit](http://cdrkit.org/) - The CD/DVD/BD recording toolkit
- [Alpine Linux](https://alpinelinux.org/) - Security-oriented, lightweight Linux distribution 