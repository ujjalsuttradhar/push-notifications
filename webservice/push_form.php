<center>
<form method="post" action="index.php?action_type=sendpush">
	<select name="device_id">
		<option>Select Device to Send</option>
		<?php
		foreach ($tokens as $token) {
			echo '<option value="'.$token->id.'">'.$token->unique_id.' ('.$token->os_type.')</option>';
		}
		?>
	</select>
	<input type="submit" name="send" value="send">
</form>
</center>
