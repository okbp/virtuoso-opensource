#!/bin/sh
#
#  $Id$
#
#  JDBC tests
#  
#  This file is part of the OpenLink Software Virtuoso Open-Source (VOS)
#  project.
#  
#  Copyright (C) 1998-2006 OpenLink Software
#  
#  This project is free software; you can redistribute it and/or modify it
#  under the terms of the GNU General Public License as published by the
#  Free Software Foundation; only version 2 of the License, dated June 1991.
#  
#  This program is distributed in the hope that it will be useful, but
#  WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#  General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License along
#  with this program; if not, write to the Free Software Foundation, Inc.,
#  51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
#  
#  

LOGFILE=tjdbc.output
export LOGFILE
. ./test_fn.sh

JDBCDIR=${JDBCDIR-../../../libsrc/JDBCDriverType4}
CURRDIR=`pwd`

BANNER "STARTED JDBC Driver TEST (tjdbc.sh)"

if [ "x$JDK2" != "x" -a "x$JDK2" != "xnone" -a -f $JDBCDIR/virtjdbc2.jar -a -f  $JDBCDIR/testsuite2.jar ]
then

STOP_SERVER
rm -f $DBLOGFILE
rm -f $DBFILE
MAKECFG_FILE $TESTCFGFILE $PORT $CFGFILE

START_SERVER $PORT 1000

ECHO "STARTED: JDBC 2 Test suite"
cd $JDBCDIR
sh ./test2.sh "jdbc:virtuoso://localhost:$PORT" > jdbc.out 2>&1
cd $CURRDIR

passed=`grep "PASSED" $JDBCDIR/jdbc.out`
passed_cnt=`grep "PASSED" $JDBCDIR/jdbc.out | wc -l`
failed=`grep "FAILED" $JDBCDIR/jdbc.out`
failed_cnt=`grep "FAILED" $JDBCDIR/jdbc.out | wc -l`

errors=0
if [ $failed_cnt -gt 0 ]
then
errors=1
ECHO "*** FAILED: Some JDBC 2 Tests failed (check $JDBCDIR/jdbc.out): $failed"
fi
if [ $passed_cnt -eq 0 ]
then
errors=1
ECHO "*** FAILED: no JDBC 2 Tests passed ! Check $JDBCDIR/jdbc.out"
fi
if [ $errors -eq 0 ]
then
ECHO "PASSED: JDBC 2 Test suite (check $JDBCDIR/jdbc.out)"
fi

SHUTDOWN_SERVER
CHECK_LOG
fi # JDK2

if [ "x$JDK3" != "x" -a "x$JDK3" != "xnone" -a -f $JDBCDIR/virtjdbc3ssl.jar -a -f  $JDBCDIR/testsuite3.jar ]
then

STOP_SERVER
rm -f $DBLOGFILE
rm -f $DBFILE
MAKECFG_FILE $TESTCFGFILE $PORT $CFGFILE

START_SERVER $PORT 1000

ECHO "STARTED: JDBC 3 Test suite"
cd $JDBCDIR
sh ./test3.sh "jdbc:virtuoso://localhost:$PORT" > jdbc3.out 2>&1
cd $CURRDIR

passed=`grep "PASSED" $JDBCDIR/jdbc3.out`
passed_cnt=`grep "PASSED" $JDBCDIR/jdbc3.out | wc -l`
failed=`grep "FAILED" $JDBCDIR/jdbc3.out`
failed_cnt=`grep "FAILED" $JDBCDIR/jdbc3.out | wc -l`

errors=0
if [ $failed_cnt -gt 0 ]
then
errors=1
ECHO "*** FAILED: Some JDBC 3 Tests failed (check $JDBCDIR/jdbc3.out): $failed"
fi
if [ $passed_cnt -eq 0 ]
then
errors=1
ECHO "*** FAILED: no JDBC 3 Tests passed ! Check $JDBCDIR/jdbc3.out"
fi
if [ $errors -eq 0 ]
then
ECHO "PASSED: JDBC 3 Test suite (check $JDBCDIR/jdbc3.out)"
fi

SHUTDOWN_SERVER
CHECK_LOG
fi # JDK3

if [ "x$JDK4" != "x" -a "x$JDK4" != "xnone" -a -f $JDBCDIR/virtjdbc4ssl.jar -a -f  $JDBCDIR/testsuite4.jar ]
then

STOP_SERVER
rm -f $DBLOGFILE
rm -f $DBFILE
MAKECFG_FILE $TESTCFGFILE $PORT $CFGFILE

START_SERVER $PORT 1000

ECHO "STARTED: JDBC 4 Test suite"
cd $JDBCDIR
sh ./test4.sh "jdbc:virtuoso://localhost:$PORT" > jdbc4.out 2>&1
cd $CURRDIR

passed=`grep "PASSED" $JDBCDIR/jdbc4.out`
passed_cnt=`grep "PASSED" $JDBCDIR/jdbc4.out | wc -l`
failed=`grep "FAILED" $JDBCDIR/jdbc4.out`
failed_cnt=`grep "FAILED" $JDBCDIR/jdbc4.out | wc -l`

errors=0
if [ $failed_cnt -gt 0 ]
then
errors=1
ECHO "*** FAILED: Some JDBC 4 Tests failed (check $JDBCDIR/jdbc4.out): $failed"
fi
if [ $passed_cnt -eq 0 ]
then
errors=1
ECHO "*** FAILED: no JDBC 4 Tests passed ! Check $JDBCDIR/jdbc4.out"
fi
if [ $errors -eq 0 ]
then
ECHO "PASSED: JDBC 4 Test suite (check $JDBCDIR/jdbc4.out)"
fi

SHUTDOWN_SERVER
CHECK_LOG
fi # JDK4

BANNER "COMPLETED JDBC Driver TEST (tjdbc.sh)"
