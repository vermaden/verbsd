#! /bin/sh

# Copyright (c) 2018 Slawomir Wojciech Wojtczak (vermaden)
# All rights reserved.
#
# THIS SOFTWARE USES FREEBSD LICENSE (ALSO KNOWN AS 2-CLAUSE BSD LICENSE)
# https://www.freebsd.org/copyright/freebsd-license.html
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that following conditions are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS 'AS IS' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# ------------------------------
# conky(1) MEMORY STATS FREEBSD
# ------------------------------
# vermaden [AT] interia [DOT] pl
# https://vermaden.wordpress.com

  MEM_PAGE=$(     sysctl -n hw.pagesize )
# MEM_SIZE=$(( $( sysctl -n vm.stats.vm.v_page_count )     * ${MEM_PAGE} / 1024 / 1024 ))
  MEM_INCT=$(( $( sysctl -n vm.stats.vm.v_inactive_count ) * ${MEM_PAGE} / 1024 / 1024 ))
  MEM_FREE=$(( $( sysctl -n vm.stats.vm.v_free_count )     * ${MEM_PAGE} / 1024 / 1024 ))
# MEM_USED=$(( ${MEM_SIZE} - ${MEM_FREE} - ${MEM_INCT} ))
# echo -n "$(( 100 * ${MEM_USED} / ${MEM_SIZE} ))%/$(( ${MEM_USED} ))M"
echo "$(( ( ${MEM_FREE} + ${MEM_INCT} ) / 1024 ))G"
