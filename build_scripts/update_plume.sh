#!/bin/bash
cd /workspaces/plasmic-build/plasmic/platform/wab
TYPEORM_CONNECTION=postgres TYPEORM_URL=postgresql://wab:SEKRET@db/wab TYPEORM_ENTITIES=/workspaces/plasmic-build/plasmic/platform/wab/src/wab/server/entities/*.ts yarn plume:dev update