/*
 * Copyright (c) 2022 Tamara Schmitz.
 *
 * This program is free software: you can redistribute it and/or modify  
 * it under the terms of the GNU General Public License as published by  
 * the Free Software Foundation, version 3.
 *
 * This program is distributed in the hope that it will be useful, but 
 * WITHOUT ANY WARRANTY; without even the implied warranty of 
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License 
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/uio.h>
#include <linux/fs.h>
#include <linux/io_uring.h>

#define CHUNK_BYTES 4096

int main(int argc, char *argv[]) {
	if (argc != 2) {
		fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
		return 1;
	}

	int fd = open(argv[1], O_RDONLY);
	if (fd <= 0) {
		perror("Open File: ");
		return 1;
	}
	struct stat fst;
	if (fstat(fd, &fst) < 0) {
		perror("Stat File: ");
		return -1;
	}
	if (!S_ISREG(fst.st_mode)) {
		fprintf(stderr, "Not a regular file");
		return -1;
	}

	off_t fsz = fst.st_size;
	off_t f_remain = fsz;
	int chunks = (int) fsz / CHUNK_BYTES;
	if (fsz % CHUNK_BYTES) chunks++;
	int chunk_curr = 0;
	struct iovec *iovectors = malloc(sizeof(struct iovec) * chunks);

	while (f_remain > 0) {
		off_t chunk_len = (f_remain > CHUNK_BYTES) ? CHUNK_BYTES : f_remain;

		void *chunk_buff = malloc(CHUNK_BYTES);
		iovectors[chunk_curr].iov_base = chunk_buff;
		iovectors[chunk_curr].iov_len = chunk_len;
		chunk_curr++;
		f_remain -= chunk_len;
	}

	int ret_read = readv(fd, iovectors, chunks);
	if (ret_read < 0) {
		perror("readv failed");
		return 1;
	}
	if (ret_read < fsz) {
		fprintf(stdout, "fewer bytes read than expected!\n");
	}

	chunk_curr = 0;
	for (int bytes_read = 0; bytes_read <= ret_read; bytes_read += CHUNK_BYTES) {
		write(2, iovectors[chunk_curr].iov_base, iovectors[chunk_curr].iov_len);
		chunk_curr++;
	}

	chunk_curr = chunks;
	while (chunk_curr > 0) {
		chunk_curr--;
		free(iovectors[chunk_curr].iov_base);
	}

	close(fd);
	return 0;
}
