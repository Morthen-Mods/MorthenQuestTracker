local _, MQT = ...

MQT_EntryMixin = {}

function MQT_EntryMixin:SetData(entry)
    self.Text:SetText(entry.text)
    self:SetChecked(entry.checked)
end

function MQT_EntryMixin:SetChecked(checked)
    self.checked = checked
    self.Check:SetTexture(checked and "Interface\\Buttons\\UI-CheckBox-Check" or nil)
end