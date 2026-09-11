#!/bin/bash
pkill -9 waybar
sleep 0.3
waybar &
disown
