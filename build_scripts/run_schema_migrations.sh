#!/bin/bash
cd /workspaces/plasmic-build/plasmic/platform/wab
TYPEORM_CONNECTION=postgres TYPEORM_URL=postgresql://wab:SEKRET@db/wab TYPEORM_ENTITIES=/workspaces/plasmic-build/plasmic/platform/wab/src/wab/server/entities/*.ts TYPEORM_MIGRATIONS=/workspaces/plasmic-build/plasmic/platform/wab/src/wab/server/migrations/*.ts yarn typeorm migration:run