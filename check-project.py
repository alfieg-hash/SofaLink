"""Validate the package inputs without downloading or building dependencies."""
import json
from pathlib import Path
import xml.etree.ElementTree as ET

root = Path(__file__).resolve().parents[1]
manifest = json.loads((root / 'io.local.SofaLink.json').read_text())
assert manifest['app-id'] == 'io.local.SofaLink'
assert manifest['command'] == 'sofalink'
assert '--device=all' in manifest['finish-args']
assert '--share=network' in manifest['finish-args']
for module in manifest['modules']:
    for source in module.get('sources', []):
        if 'path' in source:
            assert (root / source['path']).is_file(), source['path']
        if source['type'] == 'archive':
            assert len(source['sha256']) == 64
engine = manifest['modules'][-1]
assert len(engine['sources'][0]['commit']) == 40
assert '-DCHIAKI_GUI_ENABLE_SDL_GAMECONTROLLER=ON' in engine['config-opts']
for path in (root / 'packaging').glob('*.xml'):
    ET.parse(path)
ET.parse(root / 'packaging/io.local.SofaLink.svg')
for path in [root/'build-flatpak.sh', root/'install-flatpak.sh', root/'packaging/sofalink']:
    data = path.read_bytes()
    assert b'\r' not in data, f'{path.name}: must use Linux line endings'
    assert data.startswith(b'#!')
print('Package metadata, source paths, controller options and Linux line endings: PASS')
