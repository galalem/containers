#!/bin/sh
crond -b -l 2
nginx -g "daemon off;"