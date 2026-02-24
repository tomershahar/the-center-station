extends Node

## ARIA Intercom System
## ARIA (Automated Research & Infrastructure Authority) speaks through intercoms
## in every room. She is NOT a physical character — pure audio/text system.
##
## Usage from room/prop scripts:
##   await ARIA.say("Communications Maintenance: DENIED. Have a productive day.")
##   await ARIA.deny_access("Directive 12-B", "Rest cycle incomplete")
##   await ARIA.announce("Anomaly detected. Have a productive day.")
##
## ARIA's voice rules (from design spec):
##   - Always technically correct, never emotional
##   - Cites directive numbers when denying things
##   - Announces irrelevant status updates
##   - Always ends relevant statements with "Have a productive day."
##   - Never malicious — just rigidly literal

signal aria_finished(text: String)


## Primary method: ARIA says something.
## Room scripts: await ARIA.say("text")
func say(text: String) -> void:
	# Display ARIA's text — prefixed to distinguish from character dialogue
	# In a full implementation this would trigger a UI overlay with ARIA's visual style
	# For now, print to console and emit to any connected UI
	print("[ARIA] " + text)
	emit_signal("aria_finished", text)
	# Small delay to simulate speech timing (0.5s per ~10 words, minimum 1s)
	var word_count: int = text.split(" ").size()
	var duration: float = max(1.5, word_count * 0.08)
	await get_tree().create_timer(duration).timeout


## Convenience: ARIA denies access with a directive number and reason.
## Automatically formats as: "[Directive]: [Reason]. Have a productive day."
func deny_access(directive: String, reason: String) -> void:
	await say("%s: %s. Have a productive day." % [directive, reason])


## Convenience: ARIA makes a general announcement.
## Automatically appends "Have a productive day." if not already present.
func announce(message: String) -> void:
	if not message.ends_with("Have a productive day."):
		await say(message + " Have a productive day.")
	else:
		await say(message)


## Convenience: ARIA logs a safety compliance failure.
func safety_failure(protocol: String, detail: String) -> void:
	await say("Safety Protocol %s: %s. Please review station safety procedures." % [protocol, detail])
