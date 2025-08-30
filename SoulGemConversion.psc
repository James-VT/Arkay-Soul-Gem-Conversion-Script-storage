ScriptName SoulGemConversion extends ObjectReference

Message property SoulGemMessageMenu auto
Message property SoulGemConversionMenu auto
MiscObject property blackSoulGemEmpty auto
MiscObject property blackSoulGemFilled auto
MiscObject property grandSoulGemFilled auto
int property blackSoulGemEmptyCount auto
int property blackSoulGemFilledCount auto
int property blackSoulGemTotal auto
VisualEffect property SoulTrapPVFX01 auto

Event OnActivate(ObjectReference akActionRef)
	Actor PlayerRef = Game.GetPlayer()
	blackSoulGemEmpty = Game.GetFormFromFile(0x0002e500, "Skyrim.esm") as MiscObject
	blackSoulGemFilled = Game.GetFormFromFile(0x0002e504, "Skyrim.esm") as MiscObject
	grandSoulGemFilled = Game.GetFormFromFile(0x0002e4ff, "Skyrim.esm") as MiscObject
	blackSoulGemEmptyCount = PlayerRef.GetItemCount(blackSoulGemEmpty)
	blackSoulGemFilledCount = PlayerRef.GetItemCount(blackSoulGemFilled)
	blackSoulGemTotal = (blackSoulGemEmptyCount + blackSoulGemFilledCount)

	SoulGemMessageMenu(PlayerRef, blackSoulGemTotal)

endEvent

Function SoulGemMessageMenu(Actor PlayerRef, int blackSoulGemTotal, int aiButton = 0)
	If blackSoulGemTotal == 0
		Debug.Notification("You currently have no Black Soul Gems")
	ElseIf blackSoulGemTotal >= 1
		aiButton = SoulGemConversionMenu.Show()
		if aiButton == 0
			PlayerRef.RemoveItem(blackSoulGemEmpty, blackSoulGemEmptyCount)
			PlayerRef.RemoveItem(blackSoulGemFilled, blackSoulGemFilledCount)
			PlayerRef.AddItem(grandSoulGemFilled, blackSoulGemTotal)
			SoulTrapPVFX01.Play(PlayerRef, 5, self)
		ElseIf aiButton == 1

		EndIf
	EndIf
EndFunction