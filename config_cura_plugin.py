#!/usr/bin/env python

import yaml

f = open('/data/config.yaml')
conf = yaml.safe_load(f)
f.close()

conf['plugins']['cura'] = {'cura_engine': '/usr/bin/CuraEngine'}
conf['plugins']['slic3r'] = {'slic3r_engine': '/Slic3r/slic3r.pl'}

f = open('/data/config.yaml', 'w')
yaml.dump(conf, f, default_flow_style=False)
f.close()
