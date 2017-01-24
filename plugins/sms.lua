local function run(msg, matches)
 if not is_admin1(msg) then
  return "این پلاگین فقط مربوط به ادمین ها است"
 end
 if matches[2]:lower() == "inbox" then
  local dat = http.request("http://umbrella.shayan-soft.ir/sms/check.php?act=GetNewMessagesList&action=GetNewMessagesListResult")
  local sms = JSON.decode(dat)
  sms_list = ""
  i = 1
  v = #sms.rec
  for k=1,v do
   sms_list = sms_list..i.."- "..sms.rec[i].from.."  ("..sms.rec[i].date..")\n"..sms.rec[i].msg.."\n____________________\n"
   i = i+1
  end
  return "لیست پیامکهای دریافتی:\n\n"..sms_list
 elseif matches[2]:lower() == "credit" then
  local dat = http.request("http://umbrella.shayan-soft.ir/sms/credit.php")
  return "اعتبار پنل پیامک "..dat.." ریال میباشد"
 else
  local path = "از سایت بگیرید"
  local url = path..matches[2].."&text="..URL.escape(matches[3]).."&password=پسورد&username=یوزر نیم"
  local res = http.request(url)
  if res == "1-0" then
   return 'پيام با موفقيت ارسال شد'
  elseif res == "1-1" then
   return 'پيام با موفقيت ارسال شد ولی به گیرنده نرسید'
  elseif res == "2" then
   return 'خطا در ارسال، اعتبار کافی نمیباشد'
  elseif res == "3" then
   return 'خطا در ارسال، محدودیت در ارسال روزانه'
  elseif res == "4" then
   return 'خطا در ارسال، محدودیت در ارسال پیامک'
  elseif res == "7" then
   return 'در متن خود از کلمات فیلتر شده استفاده کردید'
  else
   return 'خطا در ارسال\nشماره خطا: '..res
  end
 end
end

return {
 usage = {
  "/sms (number) (txt) : ارسال پيامک",
  "sms (credit) : اعتبار",
  "sms (inbox) : صندوق ورودی",
 },
 patterns = {
  "^[/#!]([Ss]ms) (inbox)$",
  "^[/#!]([Ss]ms) (credit)$",
  "^[/#!]([Ss]ms) (%d+) (.*)",
 }, 
 run = run,
}
-- Opened By XtBot
