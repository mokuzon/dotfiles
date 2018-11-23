if g:plug.is_installed('vim-textobj-multiblock')
  let g:textobj_multiblock_blocks = [
    \	[ "'", "'", 1 ],
    \	[ '"', '"', 1 ],
    \	[ "(", ")" ],
    \	[ "[", "]" ],
    \	[ "{", "}" ],
    \	[ '<', '>' ],
  \ ]
endif
