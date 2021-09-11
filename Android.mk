LOCAL_PATH:= $(call my-dir)

# GENERAL
MY_CFLAGS	:= -g -Wall -W -O3 -Wno-unused-but-set-variable -Wno-array-bounds -DANDROID
MY_C_INCLUDES	:= $(LOCAL_PATH)/common $(LOCAL_PATH)/crypto $(LOCAL_PATH)/libwps $(LOCAL_PATH)/lwe $(LOCAL_PATH)/tls $(LOCAL_PATH)/utils

MY_SHARED_LIBS	:= libsqlite
MY_C_INCLUDES	+= external/sqlite/dist

MY_STATIC_LIBS	:= libpcap
MY_C_INCLUDES	+= external/libpcap

# DEPENDENCY: libwps
SRC_LIBWPS	:= libwps/libwps.c

# DEPENDENCY: wps
SRC_WPS	:= wps/wps_attr_build.c wps/wps_attr_parse.c wps/wps_attr_process.c wps/wps.c wps/wps_common.c wps/wps_dev_attr.c wps/wps_enrollee.c wps/wps_registrar.c wps/wps_ufd.c

# DEPENDENCY: libcrypto
MY_CFLAGS	+= -DCONFIG_TLS_INTERNAL_CLIENT -DCONFIG_TLS_INTERNAL_SERVER -DCONFIG_FIPS
SRC_CRYPTO	:= crypto/aes-cbc.c crypto/aes-ctr.c crypto/aes-eax.c crypto/aes-encblock.c crypto/aes-internal.c crypto/aes-internal-dec.c crypto/aes-internal-enc.c crypto/aes-omac1.c crypto/aes-unwrap.c crypto/aes-wrap.c crypto/des-internal.c crypto/dh_group5.c crypto/dh_groups.c crypto/md4-internal.c crypto/md5.c crypto/md5-internal.c crypto/md5-non-fips.c crypto/milenage.c crypto/ms_funcs.c crypto/rc4.c crypto/sha1.c crypto/sha1-internal.c crypto/sha1-pbkdf2.c crypto/sha1-tlsprf.c crypto/sha1-tprf.c crypto/sha256.c crypto/sha256-internal.c crypto/crypto_internal.c crypto/crypto_internal-cipher.c crypto/crypto_internal-modexp.c crypto/crypto_internal-rsa.c crypto/tls_internal.c crypto/fips_prf_internal.c

# DEPENDENCY: lwe
SRC_LWE	:= lwe/iwlib.c
MY_CFLAGS	+= -Wshadow -Wpointer-arith -Wcast-qual -Winline

# DEPENDENCY: tls
MY_CFLAGS	+= -DCONFIG_INTERNAL_LIBTOMMATH -DCONFIG_CRYPTO_INTERNAL
SRC_TLS	:= tls/asn1.c tls/bignum.c tls/pkcs1.c tls/pkcs5.c tls/pkcs8.c tls/rsa.c tls/tlsv1_client.c tls/tlsv1_client_read.c tls/tlsv1_client_write.c tls/tlsv1_common.c tls/tlsv1_cred.c tls/tlsv1_record.c tls/tlsv1_server.c tls/tlsv1_server_read.c tls/tlsv1_server_write.c tls/x509v3.c

# DEPENDENCY: utils
MY_CFLAGS	+= -DCONFIG_IPV6
SRC_UTILS	:= utils/base64.c utils/common.c utils/ip_addr.c utils/radiotap.c utils/trace.c utils/uuid.c utils/wpa_debug.c utils/wpabuf.c utils/os_unix.c utils/eloop.c

SRC_REAVER:= $(SRC_TLS) $(SRC_CRYPTO) $(SRC_WPS) $(SRC_LIBWPS) $(SRC_UTILS) \
	80211.c \
	argsparser.c \
	builder.c \
	cracker.c \
	crc.c \
	exchange.c \
	globule.c \
	iface.c \
	init.c \
	keys.c \
	main.c \
	misc.c \
	pcapfile.c \
	pins.c \
	pixie.c \
	send.c \
	session.c \
	sigalrm.c \
	sigint.c \
	version.c \
	wpscrack.c \
	wpsmon.c

include $(CLEAR_VARS)
LOCAL_MODULE		:= libiwlib
LOCAL_SRC_FILES		:= $(SRC_LWE)
LOCAL_CFLAGS		+= $(MY_CFLAGS)
LOCAL_C_INCLUDES	:= $(MY_C_INCLUDES)
LOCAL_STATIC_LIBRARIES  := $(MY_STATIC_LIBS)
LOCAL_SHARED_LIBRARIES  := $(MY_SHARED_LIBS)
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE		:= reaver
LOCAL_SRC_FILES		:= $(SRC_REAVER) utils/vendor.c
LOCAL_CFLAGS		+= $(MY_CFLAGS) -DNO_UALARM
LOCAL_C_INCLUDES	:= $(MY_C_INCLUDES)
LOCAL_STATIC_LIBRARIES  := $(MY_STATIC_LIBS) libiwlib liblog
LOCAL_SHARED_LIBRARIES  := $(MY_SHARED_LIBS)
LOCAL_LDLIBS		:= -llog
include $(BUILD_EXECUTABLE)

# Wash is made from symlinking - ln -sf reaver wash
# Otherwise it can be rebuilt with the following + modifications to makefile

# include $(CLEAR_VARS)
# LOCAL_MODULE		:= wash
# LOCAL_SRC_FILES		:= $(SRC_REAVER) utils/vendor.c
# LOCAL_CFLAGS		+= $(MY_CFLAGS) -DNO_UALARM
# LOCAL_C_INCLUDES	:= $(MY_C_INCLUDES)
# LOCAL_STATIC_LIBRARIES  := $(MY_STATIC_LIBS) libiwlib liblog
# LOCAL_SHARED_LIBRARIES  := $(MY_SHARED_LIBS)
# LOCAL_LDLIBS		:= -llog
# include $(BUILD_EXECUTABLE)
