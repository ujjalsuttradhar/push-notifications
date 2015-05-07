<center>
<form method="post" action="index.php?type=sendpush">
	<select name="token">
		<option>Select Device to Send</option>
		<?php
		foreach ($tokens as $token) {
			echo '<option value="'.$token->unique_id.'">'.$token->unique_id.' ('.$token->os_type.')</option>';
		}
		?>
	</select>
	<input type="submit" name="send" value="send">
</form>
</center>
