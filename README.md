# mkisofs-docker

[![Docker Hub](https://img.shields.io/docker/pulls/rvargas/mkisofs-docker)](https://hub.docker.com/r/rvargas/mkisofs-docker)
[![Docker Image Size](https://img.shields.io/docker/image-size/rvargas/mkisofs-docker/1.2.0)](https://hub.docker.com/r/rvargas/mkisofs-docker)

A lightweight Docker container for creating ISO 9660 filesystem images using the authentic `mkisofs` from cdrtools with native UDF support for advanced disc authoring.

## Quick Start

### Using the pre-built image (recommended)

```bash
# Pull the image (optional - Docker will pull automatically if not present)
docker pull rvargas/mkisofs-docker:1.2.0

# Show help and available options
docker run --rm rvargas/mkisofs-docker:1.2.0

# Create an ISO from files in current directory
docker run --rm -v $(pwd):/data rvargas/mkisofs-docker:1.2.0 \
  -o output.iso -V "My Volume" .
```

### Building from source (for development)

Only needed if you want to modify the container or contribute to the project:

```bash
git clone https://github.com/rvargas/mkisofs-docker.git
cd mkisofs-docker
docker build -t rvargas/mkisofs-docker:1.2.0 .
```

## Usage Examples

### Basic ISO creation

Create an ISO from files in the current directory:

```bash
docker run --rm -v $(pwd):/data rvargas/mkisofs-docker:1.2.0 \
  -o myfiles.iso -V "MyFiles" .
```

### UDF filesystem support

Create a UDF filesystem for large files (>4GB):

```bash
docker run --rm -v $(pwd):/data rvargas/mkisofs-docker:1.2.0 \
  -o large-files.iso \
  -udf \
  -V "UDF_DISK" \
  .
```

### UHD Blu-ray authoring

For UHD Blu-ray disc authoring with BDMV structure:

```bash
docker run --rm -v $(pwd):/data rvargas/mkisofs-docker:1.2.0 \
  -o uhd-bluray.iso \
  -udf \
  -V "UHD_BLURAY" \
  BDMV CERTIFICATE
```

### Advanced bootable ISO

Create a bootable ISO with specific volume label and system identifier:

```bash
docker run --rm -v $(pwd):/data rvargas/mkisofs-docker:1.2.0 \
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
docker run --rm -v /path/to/source:/data rvargas/mkisofs-docker:1.2.0 \
  -o output.iso -V "SOURCE_FILES" .
```

### Output to mounted volume

Save the ISO to a specific location:

```bash
docker run --rm \
  -v $(pwd)/source:/data \
  -v $(pwd)/output:/output \
  rvargas/mkisofs-docker:1.2.0 \
  -o /output/result.iso -V "RESULT" /data
```

## Common mkisofs Options

| Option | Description |
|--------|-------------|
| `-o file` | Output ISO file |
| `-V volid` | Volume ID (up to 32 characters) |
| `-A appid` | Application identifier |
| `-sysid id` | System identifier |
| `-udf` | Create UDF filesystem (for large files >4GB) |
| `-b bootimg` | Boot image for El Torito |
| `-c bootcat` | Boot catalog for El Torito |
| `-no-emul-boot` | No boot emulation |
| `-J` | Generate Joliet directory records |
| `-R` | Generate Rock Ridge directory information |
| `-l` | Allow full 31 character filenames |

## Container Details

- **Base image**: Ubuntu 22.04
- **Package source**: Brandon Snider's cdrtools PPA
- **Implementation**: Authentic `mkisofs` from cdrtools 3.02a09
- **UDF support**: Native UDF filesystem creation for large files
- **Working directory**: `/data`
- **Entrypoint**: `["mkisofs"]`
- **Default command**: `--help`

## Features

### ✅ **Real cdrtools**
- Authentic `mkisofs` from cdrtools (not cdrkit fork)
- Latest version 3.02a09 with all modern features
- Full compatibility with original mkisofs behavior

### ✅ **UDF Support**
- Native UDF filesystem creation
- Support for files larger than 4GB
- Perfect for UHD Blu-ray disc authoring
- Handles BDMV and CERTIFICATE directory structures

### ✅ **Advanced Features**
- El Torito bootable disc creation
- Rock Ridge and Joliet extensions
- Multi-session disc support
- Extensive customization options

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
docker run --rm -v $(pwd)/test-files:/data rvargas/mkisofs-docker:1.2.0 \
  -o test.iso -V "TEST" .

# Verify ISO was created
ls -la test.iso
```

### Test UDF support

```bash
# Create a large file for testing UDF
mkdir udf-test
dd if=/dev/zero of=udf-test/large-file.bin bs=1M count=5000  # 5GB file

# Create UDF ISO
docker run --rm -v $(pwd)/udf-test:/data rvargas/mkisofs-docker:1.2.0 \
  -o large.iso -udf -V "UDF_TEST" .
```

## Version History

- **1.2.0** - Real cdrtools implementation with native UDF support
- **1.1.x** - xorriso-based implementation (deprecated)
- **1.0.x** - Initial cdrkit-based implementation (deprecated)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [cdrtools](http://cdrtools.sourceforge.net/) - The original and authentic CD/DVD authoring tools
- [Brandon Snider](https://launchpad.net/~brandonsnider) - Maintainer of the cdrtools Ubuntu PPA
- [Ubuntu](https://ubuntu.com/) - Stable and reliable base image platform 