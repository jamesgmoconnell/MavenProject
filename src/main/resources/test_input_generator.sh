#!/bin/bash
grep @RequestMapping $1 | sed 's/^[ \t]*@RequestMapping("//g' | sed 's/")//g' > $2


