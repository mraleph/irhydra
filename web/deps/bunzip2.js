//
// Hand port of bunzip2 related parts from archive pub-package.
//

var BUNZIP2 = (function () {
  var INITIAL_CRC = 0xffffffff;

  function updateCrc(value, crc) {
    return ((crc << 8) ^
            _BZ2_CRC32_TABLE[(crc >> 24) & 0xff ^ (value & 0xff)]) &
            0xffffffff;
  }

  function finalizeCrc(crc) {
    return crc ^ 0xffffffff;
  }

  var BZH_SIGNATURE = new Uint8Array([0x42, 0x5a, 0x68]);

  var HDR_0 = 0x30;

  var COMPRESSED_MAGIC = new Uint8Array([
    0x31, 0x41, 0x59, 0x26, 0x53, 0x59]);

  var EOS_MAGIC = new Uint8Array([
    0x17, 0x72, 0x45, 0x38, 0x50, 0x90]);

  var _BZ2_CRC32_TABLE = new Uint32Array([
         0x00000000, 0x04c11db7, 0x09823b6e, 0x0d4326d9,
         0x130476dc, 0x17c56b6b, 0x1a864db2, 0x1e475005,
         0x2608edb8, 0x22c9f00f, 0x2f8ad6d6, 0x2b4bcb61,
         0x350c9b64, 0x31cd86d3, 0x3c8ea00a, 0x384fbdbd,
         0x4c11db70, 0x48d0c6c7, 0x4593e01e, 0x4152fda9,
         0x5f15adac, 0x5bd4b01b, 0x569796c2, 0x52568b75,
         0x6a1936c8, 0x6ed82b7f, 0x639b0da6, 0x675a1011,
         0x791d4014, 0x7ddc5da3, 0x709f7b7a, 0x745e66cd,
         0x9823b6e0, 0x9ce2ab57, 0x91a18d8e, 0x95609039,
         0x8b27c03c, 0x8fe6dd8b, 0x82a5fb52, 0x8664e6e5,
         0xbe2b5b58, 0xbaea46ef, 0xb7a96036, 0xb3687d81,
         0xad2f2d84, 0xa9ee3033, 0xa4ad16ea, 0xa06c0b5d,
         0xd4326d90, 0xd0f37027, 0xddb056fe, 0xd9714b49,
         0xc7361b4c, 0xc3f706fb, 0xceb42022, 0xca753d95,
         0xf23a8028, 0xf6fb9d9f, 0xfbb8bb46, 0xff79a6f1,
         0xe13ef6f4, 0xe5ffeb43, 0xe8bccd9a, 0xec7dd02d,
         0x34867077, 0x30476dc0, 0x3d044b19, 0x39c556ae,
         0x278206ab, 0x23431b1c, 0x2e003dc5, 0x2ac12072,
         0x128e9dcf, 0x164f8078, 0x1b0ca6a1, 0x1fcdbb16,
         0x018aeb13, 0x054bf6a4, 0x0808d07d, 0x0cc9cdca,
         0x7897ab07, 0x7c56b6b0, 0x71159069, 0x75d48dde,
         0x6b93dddb, 0x6f52c06c, 0x6211e6b5, 0x66d0fb02,
         0x5e9f46bf, 0x5a5e5b08, 0x571d7dd1, 0x53dc6066,
         0x4d9b3063, 0x495a2dd4, 0x44190b0d, 0x40d816ba,
         0xaca5c697, 0xa864db20, 0xa527fdf9, 0xa1e6e04e,
         0xbfa1b04b, 0xbb60adfc, 0xb6238b25, 0xb2e29692,
         0x8aad2b2f, 0x8e6c3698, 0x832f1041, 0x87ee0df6,
         0x99a95df3, 0x9d684044, 0x902b669d, 0x94ea7b2a,
         0xe0b41de7, 0xe4750050, 0xe9362689, 0xedf73b3e,
         0xf3b06b3b, 0xf771768c, 0xfa325055, 0xfef34de2,
         0xc6bcf05f, 0xc27dede8, 0xcf3ecb31, 0xcbffd686,
         0xd5b88683, 0xd1799b34, 0xdc3abded, 0xd8fba05a,
         0x690ce0ee, 0x6dcdfd59, 0x608edb80, 0x644fc637,
         0x7a089632, 0x7ec98b85, 0x738aad5c, 0x774bb0eb,
         0x4f040d56, 0x4bc510e1, 0x46863638, 0x42472b8f,
         0x5c007b8a, 0x58c1663d, 0x558240e4, 0x51435d53,
         0x251d3b9e, 0x21dc2629, 0x2c9f00f0, 0x285e1d47,
         0x36194d42, 0x32d850f5, 0x3f9b762c, 0x3b5a6b9b,
         0x0315d626, 0x07d4cb91, 0x0a97ed48, 0x0e56f0ff,
         0x1011a0fa, 0x14d0bd4d, 0x19939b94, 0x1d528623,
         0xf12f560e, 0xf5ee4bb9, 0xf8ad6d60, 0xfc6c70d7,
         0xe22b20d2, 0xe6ea3d65, 0xeba91bbc, 0xef68060b,
         0xd727bbb6, 0xd3e6a601, 0xdea580d8, 0xda649d6f,
         0xc423cd6a, 0xc0e2d0dd, 0xcda1f604, 0xc960ebb3,
         0xbd3e8d7e, 0xb9ff90c9, 0xb4bcb610, 0xb07daba7,
         0xae3afba2, 0xaafbe615, 0xa7b8c0cc, 0xa379dd7b,
         0x9b3660c6, 0x9ff77d71, 0x92b45ba8, 0x9675461f,
         0x8832161a, 0x8cf30bad, 0x81b02d74, 0x857130c3,
         0x5d8a9099, 0x594b8d2e, 0x5408abf7, 0x50c9b640,
         0x4e8ee645, 0x4a4ffbf2, 0x470cdd2b, 0x43cdc09c,
         0x7b827d21, 0x7f436096, 0x7200464f, 0x76c15bf8,
         0x68860bfd, 0x6c47164a, 0x61043093, 0x65c52d24,
         0x119b4be9, 0x155a565e, 0x18197087, 0x1cd86d30,
         0x029f3d35, 0x065e2082, 0x0b1d065b, 0x0fdc1bec,
         0x3793a651, 0x3352bbe6, 0x3e119d3f, 0x3ad08088,
         0x2497d08d, 0x2056cd3a, 0x2d15ebe3, 0x29d4f654,
         0xc5a92679, 0xc1683bce, 0xcc2b1d17, 0xc8ea00a0,
         0xd6ad50a5, 0xd26c4d12, 0xdf2f6bcb, 0xdbee767c,
         0xe3a1cbc1, 0xe760d676, 0xea23f0af, 0xeee2ed18,
         0xf0a5bd1d, 0xf464a0aa, 0xf9278673, 0xfde69bc4,
         0x89b8fd09, 0x8d79e0be, 0x803ac667, 0x84fbdbd0,
         0x9abc8bd5, 0x9e7d9662, 0x933eb0bb, 0x97ffad0c,
         0xafb010b1, 0xab710d06, 0xa6322bdf, 0xa2f33668,
         0xbcb4666d, 0xb8757bda, 0xb5365d03, 0xb1f740b4]);

  var _BIT_MASK = new Uint8Array([0, 1, 3, 7, 15, 31, 63, 127, 255]);

  function Bz2BitReader(input) {
    this.input = input;
    this.pos = 0;
    this._bitBuffer = 0;
    this._bitPos = 0;
  }

  Bz2BitReader.prototype.readByte = function () { return this.readBits(8) };

  /**
   * Read a number of bits from the input stream.
   */
  Bz2BitReader.prototype.readBits = function (numBits) {
    if (numBits == 0) {
      return 0;
    }

    if (this._bitPos == 0) {
      this._bitPos = 8;
      this._bitBuffer = this.input[this.pos++];
    }

    var value = 0;

    while (numBits > this._bitPos) {
      value = (value << this._bitPos) + (this._bitBuffer & _BIT_MASK[this._bitPos]);
      numBits -= this._bitPos;
      this._bitPos = 8;
      this._bitBuffer = this.input[this.pos++];
    }

    if (numBits > 0) {
      if (this._bitPos == 0) {
        this._bitPos = 8;
        this._bitBuffer = this.input[this.pos++];
      }

      value = (value << numBits) +
              (this._bitBuffer >> (this._bitPos - numBits) & _BIT_MASK[numBits]);

      this._bitPos -= numBits;
    }

    return value;
  };

  function Uint8ArrayBuffer() {
    this.tails = [];
    this.bufs = [this.buf = new Uint8Array(1024 * 1024)];
    this.pos  = 0;
  }

  Uint8ArrayBuffer.prototype.add = function (ch) {
    if (this.pos === this.buf.length) {
      if (this.tails.length > 0) {
        this.bufs.push(this.tails.pop());
      } else {
        this.bufs.push(this.buf = new Uint8Array(1024 * 1024));
      }
      this.pos = 0;
    }
    this.buf[this.pos++] = ch;
  };

  Uint8ArrayBuffer.prototype.finalize = function (other) {
    if (this.pos !== this.buf.length) {
      var prefix = this.buf.subarray(0, this.pos);
      var tail = this.buf.subarray(this.pos, this.buf.length - this.pos);
      this.bufs[this.bufs.length - 1] = this.buf = prefix;
      this.tails.push(tail);
    }
  };

  Uint8ArrayBuffer.prototype.addAll = function (other) {
    this.finalize();
    this.bufs = this.bufs.concat(other.bufs);
    this.buf = other.buf;
    this.pos = other.pos;
  };

  Uint8ArrayBuffer.prototype.flatten = function () {
    this.finalize();

    var len = 0;
    for (var i = 0; i < this.bufs.length; i++) {
      len += this.bufs[i].length;
    }

    var result = new Uint8Array(len), offs = 0;
    for (var i = 0; i < this.bufs.length; i++) {
      result.set(this.bufs[i], offs);
      offs += this.bufs[i].length;
    }

    return result;
  };

  var BZ_N_GROUPS = 6;
  var BZ_G_SIZE = 50;
  var BZ_N_ITERS = 4;
  var BZ_MAX_ALPHA_SIZE = 258;
  var BZ_MAX_CODE_LEN = 23;
  var BZ_MAX_SELECTORS = (2 + Math.floor(900000 / BZ_G_SIZE));
  var MTFA_SIZE = 4096;
  var MTFL_SIZE = 16;
  var BZ_RUNA = 0;
  var BZ_RUNB = 1;

  var BLOCK_COMPRESSED = 0;
  var BLOCK_EOS = 2;

  var BZ2_rNums = new Uint16Array([
     619, 720, 127, 481, 931, 816, 813, 233, 566, 247,
     985, 724, 205, 454, 863, 491, 741, 242, 949, 214,
     733, 859, 335, 708, 621, 574, 73, 654, 730, 472,
     419, 436, 278, 496, 867, 210, 399, 680, 480, 51,
     878, 465, 811, 169, 869, 675, 611, 697, 867, 561,
     862, 687, 507, 283, 482, 129, 807, 591, 733, 623,
     150, 238, 59, 379, 684, 877, 625, 169, 643, 105,
     170, 607, 520, 932, 727, 476, 693, 425, 174, 647,
     73, 122, 335, 530, 442, 853, 695, 249, 445, 515,
     909, 545, 703, 919, 874, 474, 882, 500, 594, 612,
     641, 801, 220, 162, 819, 984, 589, 513, 495, 799,
     161, 604, 958, 533, 221, 400, 386, 867, 600, 782,
     382, 596, 414, 171, 516, 375, 682, 485, 911, 276,
     98, 553, 163, 354, 666, 933, 424, 341, 533, 870,
     227, 730, 475, 186, 263, 647, 537, 686, 600, 224,
     469, 68, 770, 919, 190, 373, 294, 822, 808, 206,
     184, 943, 795, 384, 383, 461, 404, 758, 839, 887,
     715, 67, 618, 276, 204, 918, 873, 777, 604, 560,
     951, 160, 578, 722, 79, 804, 96, 409, 713, 940,
     652, 934, 970, 447, 318, 353, 859, 672, 112, 785,
     645, 863, 803, 350, 139, 93, 354, 99, 820, 908,
     609, 772, 154, 274, 580, 184, 79, 626, 630, 742,
     653, 282, 762, 623, 680, 81, 927, 626, 789, 125,
     411, 521, 938, 300, 821, 78, 343, 175, 128, 250,
     170, 774, 972, 275, 999, 639, 495, 78, 352, 126,
     857, 956, 358, 619, 580, 124, 737, 594, 701, 612,
     669, 112, 134, 694, 363, 992, 809, 743, 168, 974,
     944, 375, 748, 52, 600, 747, 642, 182, 862, 81,
     344, 805, 988, 739, 511, 655, 814, 334, 249, 515,
     897, 955, 664, 981, 649, 113, 974, 459, 893, 228,
     433, 837, 553, 268, 926, 240, 102, 654, 459, 51,
     686, 754, 806, 760, 493, 403, 415, 394, 687, 700,
     946, 670, 656, 610, 738, 392, 760, 799, 887, 653,
     978, 321, 576, 617, 626, 502, 894, 679, 243, 440,
     680, 879, 194, 572, 640, 724, 926, 56, 204, 700,
     707, 151, 457, 449, 797, 195, 791, 558, 945, 679,
     297, 59, 87, 824, 713, 663, 412, 693, 342, 606,
     134, 108, 571, 364, 631, 212, 174, 643, 304, 329,
     343, 97, 430, 751, 497, 314, 983, 374, 822, 928,
     140, 206, 73, 263, 980, 736, 876, 478, 430, 305,
     170, 514, 364, 692, 829, 82, 855, 953, 676, 246,
     369, 970, 294, 750, 807, 827, 150, 790, 288, 923,
     804, 378, 215, 828, 592, 281, 565, 555, 710, 82,
     896, 831, 547, 261, 524, 462, 293, 465, 502, 56,
     661, 821, 976, 991, 658, 869, 905, 758, 745, 193,
     768, 550, 608, 933, 378, 286, 215, 979, 792, 961,
     61, 688, 793, 644, 986, 403, 106, 366, 905, 644,
     372, 567, 466, 434, 645, 210, 389, 550, 919, 135,
     780, 773, 635, 389, 707, 100, 626, 958, 165, 504,
     920, 176, 193, 713, 857, 265, 203, 50, 668, 108,
     645, 990, 626, 197, 510, 357, 358, 850, 858, 364,
     936, 638]);

  ArchiveException = Error;

  function BZip2Decoder(data) {
    this._blockSize100k = null;
    this._tt = null;
    this._inUse16 = null;
    this._inUse = null;
    this._seqToUnseq = null;
    this._mtfa = null;
    this._mtfbase = null;
    this._selectorMtf = null;
    this._selector = null;
    this._limit = null;
    this._base = null;
    this._perm = null;
    this._minLens = null;
    this._unzftab = null;
    this._numSelectors = null;
    this._groupPos = 0;
    this._groupNo = -1;
    this._gSel = 0;
    this._gMinlen = 0;
    this._gLimit = null;
    this._gPerm = null;
    this._gBase = null;
    this._cftab = null;
    this._len = null;
    this._numInUse = 0;
  }

  var verify = false;

  BZip2Decoder.prototype.decodeBuffer = function (data) {
    var output = new Uint8ArrayBuffer();
    var br = new Bz2BitReader(data);

    this._groupPos = 0;
    this._groupNo = 0;
    this._gSel = 0;
    this._gMinlen = 0;

    if (br.readByte() != BZH_SIGNATURE[0] ||
        br.readByte() != BZH_SIGNATURE[1] ||
        br.readByte() != BZH_SIGNATURE[2]) {
      throw new ArchiveException('Invalid Signature');
    }

    this._blockSize100k = br.readByte() - HDR_0;
    if (this._blockSize100k < 0 || this._blockSize100k > 9) {
      throw new ArchiveException('Invalid BlockSize');
    }

    this._tt = new Uint32Array(this._blockSize100k * 100000);

    var combinedCrc = 0;

    while (true) {
      var type = this._readBlockType(br);
      if (type == BLOCK_COMPRESSED) {
        var storedBlockCrc = 0;
        storedBlockCrc = (storedBlockCrc << 8) | br.readByte();
        storedBlockCrc = (storedBlockCrc << 8) | br.readByte();
        storedBlockCrc = (storedBlockCrc << 8) | br.readByte();
        storedBlockCrc = (storedBlockCrc << 8) | br.readByte();

        var blockCrc = this._readCompressed(br, output);
        blockCrc = finalizeCrc(blockCrc);

        if (verify && blockCrc != storedBlockCrc) {
          throw new ArchiveException('Invalid block checksum.');
        }
        combinedCrc = ((combinedCrc << 1) | (combinedCrc >> 31)) & 0xffffffff;
        combinedCrc ^= blockCrc;
      } else if (type == BLOCK_EOS) {
        var storedCrc = 0;
        storedCrc = (storedCrc << 8) | br.readByte();
        storedCrc = (storedCrc << 8) | br.readByte();
        storedCrc = (storedCrc << 8) | br.readByte();
        storedCrc = (storedCrc << 8) | br.readByte();

        if (verify && storedCrc != combinedCrc) {
          throw new ArchiveException("Invalid combined checksum: " + combinedCrc + " : " + storedCrc);
        }

        return output.flatten();
      }
    }

    return null;
  }

  BZip2Decoder.prototype._readBlockType = function (br) {
    var eos = true;
    var compressed = true;

    // .eos_magic:48        0x177245385090 (BCD sqrt(pi))
    // .compressed_magic:48 0x314159265359 (BCD (pi))
    for (var i = 0; i < 6; ++i) {
      var b = br.readByte();
      if (b != COMPRESSED_MAGIC[i]) {
        compressed = false;
      }
      if (b != EOS_MAGIC[i]) {
        eos = false;
      }
      if (!eos && !compressed) {
        throw new ArchiveException('Invalid Block Signature');
      }
    }

    return (compressed) ? BLOCK_COMPRESSED : BLOCK_EOS;
  }

  BZip2Decoder.prototype._readCompressed = function (br, output) {
    var blockRandomized = br.readBits(1);
    var origPtr = br.readBits(8);
    origPtr = (origPtr << 8) | br.readBits(8);
    origPtr = (origPtr << 8) | br.readBits(8);

    // Receive the mapping table
    this._inUse16 = new Uint8Array(16);
    for (var i = 0; i < 16; ++i) {
      this._inUse16[i] = br.readBits(1);
    }

    this._inUse = new Uint8Array(256);
    for (var i = 0, k = 0; i < 16; ++i, k += 16) {
      if (this._inUse16[i] != 0) {
        for (var j = 0; j < 16; ++j) {
          this._inUse[k + j] = br.readBits(1);
        }
      }
    }

    this._makeMaps();
    if (this._numInUse == 0) {
      throw new ArchiveException('Data error');
    }

    var alphaSize = this._numInUse + 2;

    // Now the selectors
    var numGroups = br.readBits(3);
    if (numGroups < 2 || numGroups > 6) {
      throw new ArchiveException('Data error');
    }

    this._numSelectors = br.readBits(15);
    if (this._numSelectors < 1) {
      throw new ArchiveException('Data error');
    }

    this._selectorMtf = new Uint8Array(BZ_MAX_SELECTORS);
    this._selector = new Uint8Array(BZ_MAX_SELECTORS);

    for (var i = 0; i < this._numSelectors; ++i) {
      var j = 0;
      while (true) {
        var b = br.readBits(1);
        if (b == 0) {
          break;
        }
        j++;
        if (j >= numGroups) {
          throw new ArchiveException('Data error');
        }
      }

      this._selectorMtf[i] = j;
    }

    // Undo the MTF values for the selectors.
    var pos = new Uint8Array(BZ_N_GROUPS);
    for (var i = 0; i < numGroups; ++i) {
      pos[i] = i;
    }

    for (var i = 0; i < this._numSelectors; ++i) {
      var v = this._selectorMtf[i];
      var tmp = pos[v];
      while (v > 0) {
        pos[v] = pos[v - 1];
        v--;
      }
      pos[0] = tmp;
      this._selector[i] = tmp;
    }

    // Now the coding tables
    this._len = new Array(BZ_N_GROUPS);

    for (var t = 0; t < numGroups; ++t) {
      this._len[t] = new Uint8Array(BZ_MAX_ALPHA_SIZE);

      var c = br.readBits(5);
      for (var i = 0; i < alphaSize; ++i) {
        while (true) {
          if (c < 1 || c > 20) {
            throw new ArchiveException('Data error');
          }
          var b = br.readBits(1);
          if (b == 0) {
            break;
          }
          b = br.readBits(1);
          if (b == 0) {
            c++;
          } else {
            c--;
          }
        }
        this._len[t][i] = c;
      }
    }

    // Create the Huffman decoding tables
    this._limit = new Array(BZ_N_GROUPS);
    this._base = new Array(BZ_N_GROUPS);
    this._perm = new Array(BZ_N_GROUPS);
    this._minLens = new Int32Array(BZ_N_GROUPS);

    for (var t = 0; t < numGroups; t++) {
      this._limit[t] = new Int32Array(BZ_MAX_ALPHA_SIZE);
      this._base[t] = new Int32Array(BZ_MAX_ALPHA_SIZE);
      this._perm[t] = new Int32Array(BZ_MAX_ALPHA_SIZE);

      var minLen = 32;
      var maxLen = 0;
      for (var i = 0; i < alphaSize; ++i) {
        if (this._len[t][i] > maxLen) {
          maxLen = this._len[t][i];
        }
        if (this._len[t][i] < minLen) {
          minLen = this._len[t][i];
        }
      }

      this._hbCreateDecodeTables(this._limit[t], this._base[t], this._perm[t], this._len[t],
                            minLen, maxLen, alphaSize);

      this._minLens[t] = minLen;
    }

    // Now the MTF values
    var EOB = this._numInUse + 1;
    var nblockMAX = 100000 * this._blockSize100k;
    var groupNo  = -1;
    var groupPos = 0;

    this._unzftab = new Int32Array(256);

    // MTF init
    this._mtfa = new Uint8Array(MTFA_SIZE);
    this._mtfbase = new Int32Array((256 / MTFL_SIZE) | 0);

    var kk = MTFA_SIZE - 1;
    for (var ii = ((256 / MTFL_SIZE)|0) - 1; ii >= 0; ii--) {
      for (var jj = MTFL_SIZE - 1; jj >= 0; jj--) {
        this._mtfa[kk] = ii * MTFL_SIZE + jj;
        kk--;
      }
      this._mtfbase[ii] = kk + 1;
    }

    var nblock = 0;
    this._groupPos = 0;
    this._groupNo = -1;
    var nextSym = this._getMtfVal(br);
    var uc = 0;

    while (true) {
      if (nextSym == EOB) {
        break;
      }

      if (nextSym == BZ_RUNA || nextSym == BZ_RUNB) {
        var es = -1;
        var N = 1;
        do {
          // Check that N doesn't get too big, so that es doesn't
          // go negative.  The maximum value that can be
          // RUNA/RUNB encoded is equal to the block size (post
          // the initial RLE), viz, 900k, so bounding N at 2
          // million should guard against overflow without
          // rejecting any legitimate inputs.
          if (N >= 2 * 1024 * 1024) {
            throw new ArchiveException('Data error');
          }

          if (nextSym == BZ_RUNA) {
            es = es + (0 + 1) * N;
          } else if (nextSym == BZ_RUNB) {
            es = es + (1 + 1) * N;
          }

          N = N * 2;

          nextSym = this._getMtfVal(br);
        } while (nextSym == BZ_RUNA || nextSym == BZ_RUNB);

        es++;

        uc = this._seqToUnseq[this._mtfa[this._mtfbase[0]]];
        this._unzftab[uc] += es;

        while (es > 0) {
          if (nblock >= nblockMAX) {
            throw new ArchiveException('Data error');
          }

          this._tt[nblock] = uc;

          nblock++;
          es--;
        };

        continue;
      } else {
        if (nblock >= nblockMAX) {
          throw new ArchiveException('Data error');
        }

        // uc = MTF ( nextSym-1 )
        var nn = nextSym - 1;

        if (nn < MTFL_SIZE) {
          // avoid general-case expense
          var pp = this._mtfbase[0];
          uc = this._mtfa[pp + nn];
          while (nn > 3) {
            var z = pp + nn;
            this._mtfa[(z)] = this._mtfa[(z)-1];
            this._mtfa[(z) - 1] = this._mtfa[(z) - 2];
            this._mtfa[(z) - 2] = this._mtfa[(z) - 3];
            this._mtfa[(z) - 3] = this._mtfa[(z) - 4];
            nn -= 4;
          }
          while (nn > 0) {
            this._mtfa[(pp+nn)] = this._mtfa[(pp + nn) - 1];
            nn--;
          }
          this._mtfa[pp] = uc;
        } else {
          // general case
          var lno = (nn / MTFL_SIZE)|0;
          var off = nn % MTFL_SIZE;
          var pp = this._mtfbase[lno] + off;
          uc = this._mtfa[pp];
          while (pp > this._mtfbase[lno]) {
            this._mtfa[pp] = this._mtfa[pp - 1];
            pp--;
          }
          this._mtfbase[lno]++;
          while (lno > 0) {
            this._mtfbase[lno]--;
            this._mtfa[this._mtfbase[lno]] = this._mtfa[this._mtfbase[lno - 1] + MTFL_SIZE - 1];
            lno--;
          }
          this._mtfbase[0]--;
          this._mtfa[this._mtfbase[0]] = uc;
          if (this._mtfbase[0] == 0) {
            kk = MTFA_SIZE-1;
            for (var ii = ((256 / MTFL_SIZE)|0) - 1; ii >= 0; ii--) {
              for (var jj = MTFL_SIZE - 1; jj >= 0; jj--) {
                this._mtfa[kk] = this._mtfa[this._mtfbase[ii] + jj];
                kk--;
              }
              this._mtfbase[ii] = kk + 1;
            }
          }
        }

        // end uc = MTF ( nextSym-1 )
        this._unzftab[this._seqToUnseq[uc]]++;
        this._tt[nblock] = (this._seqToUnseq[uc]);
        nblock++;

        nextSym = this._getMtfVal(br);
        continue;
      }
    }

    // Now we know what nblock is, we can do a better sanity
    // check on s->origPtr.
    if (origPtr < 0 || origPtr >= nblock) {
      throw new ArchiveException('Data error');
    }

    // Set up cftab to facilitate generation of T^(-1)
    // Check: unzftab entries in range.
    for (var i = 0; i <= 255; i++) {
      if (this._unzftab[i] < 0 || this._unzftab[i] > nblock) {
        throw new ArchiveException('Data error');
      }
    }

    // Actually generate cftab.
    this._cftab = new Int32Array(257);
    this._cftab[0] = 0;
    for (var i = 1; i <= 256; i++) {
      this._cftab[i] = this._unzftab[i - 1];
    }

    for (var i = 1; i <= 256; i++) {
      this._cftab[i] += this._cftab[i - 1];
    }

    // Check: cftab entries in range.
    for (var i = 0; i <= 256; i++) {
      if (this._cftab[i] < 0 || this._cftab[i] > nblock) {
        // s->cftab[i] can legitimately be == nblock
        throw new ArchiveException('Data error');
      }
    }

    // Check: cftab entries non-descending.
    for (var i = 1; i <= 256; i++) {
      if (this._cftab[i - 1] > this._cftab[i]) {
        throw new ArchiveException('Data error');
      }
    }

    // compute the T^(-1) vector
    for (var i = 0; i < nblock; i++) {
      uc = (this._tt[i] & 0xff);
      this._tt[this._cftab[uc]] |= (i << 8);
      this._cftab[uc]++;
    }

    var blockCrc = INITIAL_CRC;

    var tPos = this._tt[origPtr] >> 8;
    var numBlockUsed = 0;
    var k0;
    var rNToGo = 0;
    var rTPos = 0;

    if (blockRandomized != 0) {
      rNToGo = 0;
      rTPos = 0;

      if (tPos >= 100000 * this._blockSize100k) {
        throw new ArchiveException('Data error');
      }
      tPos = this._tt[tPos];
      k0 = tPos & 0xff;
      tPos >>= 8;

      numBlockUsed++;

      if (rNToGo == 0) {
        rNToGo = BZ2_rNums[rTPos];
        rTPos++;
        if (rTPos == 512) {
          rTPos = 0;
        }
      }
      rNToGo--;

      k0 ^= ((rNToGo == 1) ? 1 : 0);
    } else {
      // c_tPos is unsigned, hence test < 0 is pointless.
      if (tPos >= 100000 * this._blockSize100k) {
        return blockCrc;
      }
      tPos = this._tt[tPos];
      k0 = (tPos & 0xff);
      tPos >>= 8;
      numBlockUsed++;
    }

    // UnRLE to output
    var c_state_out_len = 0;
    var c_state_out_ch = 0;
    var s_save_nblockPP = nblock + 1;
    var c_nblock_used = numBlockUsed;
    var c_k0 = k0;
    var k1;

    if (blockRandomized != 0) {
      while (true) {
        // try to finish existing run
        while (true) {
          if (c_state_out_len == 0) {
            break;
          }

          output.add(c_state_out_ch);
          blockCrc = updateCrc(c_state_out_ch, blockCrc);

          c_state_out_len--;
        }

        // can a new run be started?
        if (c_nblock_used == s_save_nblockPP) {
          return blockCrc;
        }

        // Only caused by corrupt data stream?
        if (c_nblock_used > s_save_nblockPP) {
          throw new ArchiveException('Data error.');
        }

        c_state_out_len = 1;
        c_state_out_ch = k0;
        tPos = this._tt[tPos];
        k1 = tPos & 0xff;
        tPos >>= 8;
        if (rNToGo == 0) {
          rNToGo = BZ2_rNums[rTPos];
          rTPos++;
          if (rTPos == 512) {
            rTPos = 0;
          }
        }
        rNToGo--;
        k1 ^= ((rNToGo == 1) ? 1 : 0);
        c_nblock_used++;
        if (c_nblock_used == s_save_nblockPP) {
          continue;
        }
        if (k1 != k0) {
          k0 = k1;
          continue;
        }

        c_state_out_len = 2;
        tPos = this._tt[tPos];
        k1 = tPos & 0xff;
        tPos >>= 8;
        if (rNToGo == 0) {
          rNToGo = BZ2_rNums[rTPos];
          rTPos++;
          if (rTPos == 512) {
            rTPos = 0;
          }
        }
        k1 ^= ((rNToGo == 1) ? 1 : 0);
        c_nblock_used++;
        if (c_nblock_used == s_save_nblockPP) {
          continue;
        }
        if (k1 != k0) {
          k0 = k1;
          continue;
        }

        c_state_out_len = 3;
        tPos = this._tt[tPos];
        k1 = tPos & 0xff;
        tPos >>= 8;
        if (rNToGo == 0) {
          rNToGo = BZ2_rNums[rTPos];
          rTPos++;
          if (rTPos == 512) {
            rTPos = 0;
          }
        }
        k1 ^= ((rNToGo == 1) ? 1 : 0);
        c_nblock_used++;
        if (c_nblock_used == s_save_nblockPP) {
          continue;
        }
        if (k1 != k0) {
          k0 = k1;
          continue;
        }

        tPos = this._tt[tPos];
        k1 = tPos & 0xff;
        tPos >>= 8;
        if (rNToGo == 0) {
          rNToGo = BZ2_rNums[rTPos];
          rTPos++;
          if (rTPos == 512) {
            rTPos = 0;
          }
        }
        k1 ^= ((rNToGo == 1) ? 1 : 0);
        c_nblock_used++;
        c_state_out_len = k1 + 4;

        tPos = this._tt[tPos];
        k0 = tPos & 0xff;
        tPos >>= 8;
        if (rNToGo == 0) {
          rNToGo = BZ2_rNums[rTPos];
          rTPos++;
          if (rTPos == 512) {
            rTPos = 0;
          }
        }
        k0 ^= ((rNToGo == 1) ? 1 : 0);
        c_nblock_used++;
      }
    } else {
      while (true) {
        // try to finish existing run
        if (c_state_out_len > 0) {
          while (true) {
            if (c_state_out_len == 1) {
              break;
            }

            output.add(c_state_out_ch);
            blockCrc = updateCrc(c_state_out_ch, blockCrc);

            c_state_out_len--;
          }

          output.add(c_state_out_ch);
          blockCrc = updateCrc(c_state_out_ch, blockCrc);
        }

        // Only caused by corrupt data stream?
        if (c_nblock_used > s_save_nblockPP) {
          throw new ArchiveException('Data error');
        }

        // can a new run be started?
        if (c_nblock_used == s_save_nblockPP) {
          c_state_out_len = 0;
          return blockCrc;
        }

        c_state_out_ch = c_k0;

        var k1;

        if (tPos >= 100000 * this._blockSize100k) {
          throw new ArchiveException('Data Error');
        }
        tPos = this._tt[tPos];
        k1 = tPos & 0xff;
        tPos >>= 8;

        c_nblock_used++;
        if (k1 != c_k0) {
          c_k0 = k1;
          output.add(c_state_out_ch);
          blockCrc = updateCrc(c_state_out_ch, blockCrc);
          c_state_out_len = 0;
          continue;
        }

        if (c_nblock_used == s_save_nblockPP) {
          output.add(c_state_out_ch);
          blockCrc = updateCrc(c_state_out_ch, blockCrc);
          c_state_out_len = 0;
          continue;
        }

        c_state_out_len = 2;
        if (tPos >= 100000 * this._blockSize100k) {
          throw new ArchiveException('Data Error');
        }
        tPos = this._tt[tPos];
        k1 = tPos & 0xff;
        tPos >>= 8;
        c_nblock_used++;

        if (c_nblock_used == s_save_nblockPP) {
          continue;
        }

        if (k1 != c_k0) {
          c_k0 = k1;
          continue;
        }

        c_state_out_len = 3;
        if (tPos >= 100000 * this._blockSize100k) {
          throw new ArchiveException('Data Error');
        }
        tPos = this._tt[tPos];
        k1 = tPos & 0xff;
        tPos >>= 8;
        c_nblock_used++;

        if (c_nblock_used == s_save_nblockPP) {
          continue;
        }

        if (k1 != c_k0) {
          c_k0 = k1;
          continue;
        }

        if (tPos >= 100000 * this._blockSize100k) {
          throw new ArchiveException('Data Error');
        }
        tPos = this._tt[tPos];
        k1 = tPos & 0xff;
        tPos >>= 8;
        c_nblock_used++;

        c_state_out_len = k1 + 4;

        if (tPos >= 100000 * this._blockSize100k) {
          throw new ArchiveException('Data Error');
        }
        tPos = this._tt[tPos];
        c_k0 = tPos & 0xff;
        tPos >>= 8;

        c_nblock_used++;
      }
    }

    return blockCrc;
  }

  BZip2Decoder.prototype._getMtfVal = function (br) {
    if (this._groupPos == 0) {
      this._groupNo++;
      if (this._groupNo >= this._numSelectors) {
        throw new ArchiveException('Data error');
      }

      this._groupPos = BZ_G_SIZE;
      this._gSel = this._selector[this._groupNo];
      this._gMinlen = this._minLens[this._gSel];
      this._gLimit = this._limit[this._gSel];
      this._gPerm = this._perm[this._gSel];
      this._gBase = this._base[this._gSel];
    }

    this._groupPos--;
    var zn = this._gMinlen;
    var zvec = br.readBits(zn);

    while (true) {
      if (zn > 20) {
        throw new ArchiveException('Data error');
      }
      if (zvec <= this._gLimit[zn]) {
        break;
      }

      zn++;
      var zj = br.readBits(1);
      zvec = (zvec << 1) | zj;
    }

    if (zvec - this._gBase[zn] < 0 || zvec - this._gBase[zn] >= BZ_MAX_ALPHA_SIZE) {
      throw new ArchiveException('Data error');
    }

    return this._gPerm[zvec - this._gBase[zn]];
  }

  BZip2Decoder.prototype._hbCreateDecodeTables = function(limit, base,
                            perm, length,
                            minLen, maxLen, alphaSize) {
    var pp = 0;
    for (var i = minLen; i <= maxLen; i++) {
      for (var j = 0; j < alphaSize; j++) {
        if (length[j] == i) {
          perm[pp] = j; pp++;
        }
      }
    }

    for (var i = 0; i < BZ_MAX_CODE_LEN; i++) {
      base[i] = 0;
    }

    for (var i = 0; i < alphaSize; i++) {
      base[length[i]+1]++;
    }

    for (var i = 1; i < BZ_MAX_CODE_LEN; i++) {
      base[i] += base[i - 1];
    }

    for (var i = 0; i < BZ_MAX_CODE_LEN; i++) {
      limit[i] = 0;
    }

    var vec = 0;

    for (var i = minLen; i <= maxLen; i++) {
      vec += (base[i + 1] - base[i]);
      limit[i] = vec-1;
      vec <<= 1;
    }

    for (var i = minLen + 1; i <= maxLen; i++) {
      base[i] = ((limit[i - 1] + 1) << 1) - base[i];
    }
  }

  BZip2Decoder.prototype._makeMaps = function () {
    this._numInUse = 0;
    this._seqToUnseq = new Uint8Array(256);
    for (var i = 0; i < 256; ++i) {
      if (this._inUse[i] != 0) {
        this._seqToUnseq[this._numInUse++] = i;
      }
    }
  }

  return function (buffer) {
    return new BZip2Decoder().decodeBuffer(new Uint8Array(buffer));
  };
})();
