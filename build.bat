@echo off
set local
set MIX_ENV=prod
mix deps.get --only prod
mix compile
mix phx.digest
mix release --overwrite
_build\dev\rel\shop\bin\shop start
endlocal