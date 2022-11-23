local func = luatexbase.new_luafunction'betterprotrusionboundary'
local my_whatsit = luatexbase.new_whatsit'betterprotrusionboundary'
local whatsit_id = node.id'whatsit'
local glyph_id = node.id'glyph'
local user_defined = node.subtype'user_defined'
token.set_lua('betterprotrusionboundary', func, 'protected')
local modes = tex.getmodevalues()
lua.get_functions_table()[func] = function()
  local mode = tex.nest.top.mode
  if mode < 0 then mode = -mode end
  if modes[mode] == 'vertical' then
  token.put_next(token.new(func, token.command_id'lua_call'))
    return tex.forcehmode()
  end
  local n = node.new(whatsit_id, user_defined)
  n.user_id = my_whatsit
  n.type = 100
  n.value = token.scan_int()
  node.write(n)
end

luatexbase.add_to_callback('pre_linebreak_filter', function(head)
  for n, s in node.traverse_id(whatsit_id, head) do if s == user_defined and n.user_id == my_whatsit then
    assert(n.value == 1, 'boundarytypes beside 1 not yet supported')
    if n.value & 1 == 1 then
      for nn, id in node.traverse(n.next) do
        local char, fid = node.is_glyph(nn)
        if char then
          token.put_next(token.create'lpcode', token.new(fid, token.command_id'set_font'), token.new(char, token.command_id'char_given'))
          local width = (font.getparameters(fid).quad or 0) * token.scan_int() // 1000
          if not (width == 0) then
            local kern = node.new('kern', 1)
            -- local kern = node.new('margin_kern', 0)
            kern.kern = -width
            -- kern.glyph = char
            head = node.insert_after(head, n, kern)
          end
          break
        elseif not node.protrusion_skippable(nn) then
          break
        elseif fid == whatsit_id and nn.subtype == user_defined and nn.user_id == my_whatsit and nn.value & 1 == 1 then
          break
        end
      end
    end
    if n.value & 2 == 2 then
      local nn = n.prev
      while nn do
        local char, fid = node.is_glyph(nn)
        if char then
          token.put_next(token.create'rpcode', token.new(fid, token.command_id'set_font'), token.new(char, token.command_id'char_given'))
          local width = (font.getparameters(fid).quad or 0) * token.scan_int() // 1000
          if not (width == 0) then
            local kern = node.new('kern', 1)
            -- local kern = node.new('margin_kern', 1)
            kern.kern = -width
            -- kern.glyph = char
            head = node.insert_before(head, n, kern)
          end
          break
        elseif not node.protrusion_skippable(nn) then
          break
        end
        nn = nn.prev
      end
    end
    head = node.remove(head, n)
  end end
  return head
end, 'betterprotrusionboundary')