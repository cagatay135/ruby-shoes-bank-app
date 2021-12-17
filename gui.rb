Shoes.app(:maxwidth => 500 ,:maxheight => 500 , :resizable => false , :fullscreen => false , title: "BANK OF CAGATAY",) do
require 'sqlite3'

@db = SQLite3::Database.open 'user.db'
@db.execute "CREATE TABLE IF NOT EXISTS user(ad TEXT, soyad TEXT , tc INT , mail TEXT , parola TEXT , last_login TEXT , bakiye REAL , tl_hesap REAL, tl2_hesap REAL, usd_hesap REAL, euro_hesap REAL)"
flow height:"100%" do
    @user_profile = stack width: "50%" , height:"100%" do
    def ana
    background "#292b5c"
    bank_image = image "./logo/bank.png" , width: "40%" , height: "20%"
    bank_image.move("30%" , "12%")

   text = para "BANKAMIZA HOŞGELDİNİZ" , stroke: white , size: "medium" , align: "center" , margin:[0,"37%",0,0], weight:"bold"
   text2 = para "Paran Bizimle Tamamen Güvende Kalacaktır Para Yatırma , Para Çekme , Döviz Alım Satım , Mail Bildirimleri Dahil Birçok Hizmeti Bankamızda Bulabileceksiniz" , stroke: "#6c6daa" , size: "small" , align: "center" , margin:[0,"4%",0,0], weight:"bold"

   next_image = image "./logo/next.png" , width:50 , height:50 
   next_image.move("42%" , "69%")

    reg = button "Kayıt Ol" , margin:["5%","13%",0,0]
   	reg.style width: "92%" , align:"center"
    reg.style height: "7%"

    reg.click{
    	@main.clear do
    		register_user
    		end
    }

    log = button "Giriş Yap" , margin:["5%","16%",0,0]
   	log.style width: "92%" , align:"center"
    log.style height: "7%"

    log.click {
    		@main.clear do
    			 background "#363a81"
      		     cumle = para "Giriş Yap" , stroke: white , size: "medium" , align: "center" , margin:[0,"7%",0,0], weight:"bold"
     		     para "Ad : " , stroke: white , size: "small" , margin:["5%","7%",0,0], weight:"bold"
                 namex= edit_line width: "58%" 
                 namex.move("40%","17%")

                 para "TC No : " , stroke: white , size: "small" , margin:["5%","7%",0,0], weight:"bold"
                 tc = edit_line width: "58%"
     			 tc.move("40%","27%")

      		     para "Parola : " , stroke: white , size: "small" , margin:["5%","7%",0,0], weight:"bold"
    		     parola = edit_line width: "58%"
                 parola.move("40%","38%")

     			 giris_yap = button "Giriş Yap" , margin:["5%","5%",0,0] 
   	             giris_yap.style width: "92%"
                 giris_yap.style height: "7%"

                 giris_yap.click do
                 yazi = namex.text
				 count = @db.execute "SELECT * FROM user WHERE ad = '#{namex.text}' AND tc = #{tc.text} AND parola = '#{parola.text}'"
				 @cont_tc = tc.text
				 @cont_name = namex.text
				 @cont_parola = parola.text
                 if count.length>0
                 	last_login = Time.new
                 	last_login = last_login.strftime("%d %B %Y %k:%M")
                 	@user_profile.clear do
                 		background "#292b5c"
					    bank_image = image "./logo/bank.png" , width: "40%" , height: "20%"
					    bank_image.move("30%" , "12%")

					   text = para "BANKAMIZA HOŞGELDİN" , stroke: white , size: "medium" , align: "center" , margin:[0,"37%",0,0]
					   para count[0][0].upcase + " " + count[0][1].upcase ,  stroke: white , size: "medium" , align: "center" 

					   para "Son Giriş" ,stroke:white , size: "xx-small" , align: "center" , margin:[0,"1%",0,0]
  					   last_login_text = para last_login ,stroke:white , size: "x-small" , align: "center" , margin:[0,"1%",0,0]

					   text2 = para "Paran Bizimle Tamamen Güvende Kalacaktır Para Yatırma , Para Çekme , Döviz Alım Satım , Mail Bildirimleri Dahil Birçok Hizmeti Bankamızda Bulabileceksiniz" , stroke: "#6c6daa" , size: "small" , align: "center" , margin:[0,"3%",0,0]

  					    next_image = image "./logo/next.png" , width:50 , height:50 
  						next_image.move("42%" , "81%")

					   logout_button  = button "Çıkış Yap" , margin:["5%","11%",0,0]
					   logout_button.style width: "92%" , align:"center"
					   logout_button.style height: "7%"
					   logout_button.click{
					   	@user_profile.clear do
					   		ana
					   	end
					   	@main.clear do 
					   		register_user
					   	end
					   }
  	

                 end

                 def procces
                 @main.clear do
                 			background "#363a81"
                 			fill  "./logo/user.png"
  							oval 125, 7, 60 , strokewidth:4 
                 			detail = stack width:"90%" , margin:["10%","15%",0,0]  do
                 			def amount
                 			background white
                 			cumle = para "Tüm Birikimler" , stroke: black , size: "small" , align: "left" , margin:[5,"7%",0,0] , weight:"bold"
                 			cumleX = para "Kullanılabilir Bakiye" , stroke: gray , size: "xx-small" , align: "left" , margin:[5,10,0,0], weight:"bold" 
                 			bakiyex = 0
                 			tl_hesap = @db.execute "SELECT tl_hesap FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
                 		    tl2_hesap = @db.execute "SELECT tl2_hesap FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
                 			usd_hesap = @db.execute "SELECT usd_hesap FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
                 			euro_hesap = @db.execute "SELECT euro_hesap FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"

                 			if tl_hesap[0][0] >= 0
                 				bakiyex = tl_hesap[0][0]
                 				@db.execute "UPDATE user SET bakiye = #{bakiyex} WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
                 			end

                 			if tl2_hesap[0][0] >= 0
                 				bakiyex = tl2_hesap[0][0]
                 				@db.execute "UPDATE user SET bakiye = bakiye + #{bakiyex} WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
                 			end

                 			if usd_hesap[0][0] >= 0
                 				bakiyex = usd_hesap[0][0]
                 				@db.execute "UPDATE user SET bakiye = bakiye + #{bakiyex} WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
                 			end

                 			if euro_hesap[0][0] >= 0
                 				bakiyex = euro_hesap[0][0]
                 				@db.execute "UPDATE user SET bakiye = bakiye + #{bakiyex} WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
                 			end

                 			bakiye = @db.execute "SELECT bakiye FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"

                 			para bakiye[0][0].ceil , " TL", weight:"bold" , margin:[5,8,0,0]
                 			end
                 			amount
                 			end


                 			icons = stack width:"90%" , margin:["10%","3%",0,0] do
                 			para "Tüm İşlemler" , stroke: white , size: "medium" , align: "center" , margin:[0,0,0,"5%"] , weight:"bold"
                 			flow do deposit = image "./logo/deposit.png" , margin:[0,0,0,0]
									widthraw = image "./logo/widthraw.png" , margin:[25,0,0,0]
									mail = image "./logo/openwallet.png" , margin:[25,0,0,0]
									deposit.click{icons.clear do  para "Para Yatır" , stroke: white , size: "medium" , align: "center" , margin:[0,0,0,"22%"]
									para "Yatırlacak Tutar : " , stroke: white , size: "x-small" , align: "left" , weight:"bold"	
									money = edit_line width: "50%" 
									money.move("50%" , "15%")
									deposit_accept = button "İşlemi Onayla" , width:"40%" , height:"30%", margin:["35%",10,0,0]
									deposit_accept.click{
									if money.text.to_i <= 0
										money.text = "Geçersiz Değer"																																							
									else
										@db.execute "UPDATE user SET tl_hesap = tl_hesap + #{money.text.to_i} WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
										money.text = "Başarılı İşlem"
										detail.clear do amount end 
									end
									}
									x = image "./logo/back.png" , width: 50 , height: 50
									x.move("44%" , 285)
									x.click{icons.clear do 
										procces
									end}
									end      
									}
									widthraw.click{icons.clear do  para "Para Çek" , stroke: white , size: "medium" , align: "center" , margin:[0,0,0,"22%"] , weight:"bold"
									para "Çekilecek Tutar : " , stroke: white , size: "x-small" , align: "left" , weight:"bold"	
									money = edit_line width: "50%" 
									money.move("50%" , "15%")
									deposit_accept = button "İşlemi Onayla" , width:"40%" , height:"30%", margin:["35%",10,0,0]
									deposit_accept.click{
									kalan_bakiye = @db.execute "SELECT tl_hesap FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
									if money.text.to_i > kalan_bakiye[0][0]
										money.text = "Yetersiz Bakiye"

									elsif money.text.to_i <= 0
										money.text = "Geçersiz Değer"

									else
										@db.execute "UPDATE user SET tl_hesap = tl_hesap - #{money.text.to_i} WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
										money.text = "Başarılı İşlem"
										detail.clear do amount end 
									end
									}
									x = image "./logo/back.png" , width: 50 , height: 50
									x.move("44%" , 285)
									x.click{icons.clear do 
										procces
									end}
									end 					
									}
									mail.click{icons.clear do  para "Hesap Aç" , stroke: white , size: "medium" , align: "center" , margin:[0,0,0,25], weight:"bold"
									para "Açmak İstediğiniz Hesap : " , stroke: white , size: "x-small" , align: "center" , weight:"bold"
									list_doviz = list_box items: ["TL", "USD", "EURO"] , margin:[25,0,0,0] 
									hesap_ac = button "HESABI AÇ"  , margin:["33%",25,0,0] , width:"40%" , height:"15%"
									@yazi = para "" , margin:[50,50,0,0] , stroke:white , weight:"bold" , size:"x-small"
									x = image "./logo/back.png" , width: 50 , height: 50
									x.move("44%" , 285)
									x.click{icons.clear do 
										procces
									end}
									hesap_ac.click{
									if list_doviz.text == "TL" 
										tl_hesap2 = @db.execute "SELECT tl2_hesap FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
										if tl_hesap2[0][0] == -1 
											@db.execute "UPDATE user SET tl2_hesap = tl2_hesap + #{1} WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
											@yazi.replace "Tl Hesabınız Oluşturuldu"
										else 
											@yazi.replace "Maximum Sayıda TL Hesabı"
										end
									elsif list_doviz.text == "USD"
										usd_hesap = @db.execute "SELECT usd_hesap FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
										if usd_hesap[0][0] == -1 
											@db.execute "UPDATE user SET usd_hesap = usd_hesap + #{1} WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
											@yazi.replace "USD Hesabınız Oluşturuldu"
										else 
											@yazi.replace "Maximum Sayıda USD Hesabı"
										end
									elsif list_doviz.text == "EURO"
										euro_hesap = @db.execute "SELECT euro_hesap FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
										if euro_hesap[0][0] == -1 
											@db.execute "UPDATE user SET euro_hesap = euro_hesap + #{1} WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
											@yazi.replace "EURO Hesabınız Oluşturuldu"
										else 
											@yazi.replace "Maximum Sayıda EURO Hesabı" 
										end
									end
									}
									end}
									end
							flow do para "Para Yatır" , margin:[5,5,0,0] , size: "xx-small" , stroke: white , weight:"bold"
									para "Para Çek" , margin:[40,5,0,0] , stroke: white , size: "xx-small" , weight:"bold"
									para "Hesap Aç" , margin:[75,5,0,0] , stroke: white , size: "xx-small", weight:"bold"
					
							end
							flow margin:[0,20,0,0] do 
									transfer = image "./logo/transfer.png" , margin:[0,0,0,0]
									para_gonder = image "./logo/sendmoney.png" , margin:[25,0,0,0]
									hesap_bilgi = image "./logo/info.png" , margin:[25,0,0,0]
									transfer.click {
									icons.clear do  para "Transfer Yap" , stroke: white , size: "medium" , align: "center" , margin:[0,0,0,"3%"] , weight:"bold"
									para "Transfer Yapılan Hesap : " , stroke: white , size: "x-small" , align: "center"  , weight:"bold"
									tl_hesap2 = @db.execute "SELECT tl2_hesap FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
									usd_hesap = @db.execute "SELECT usd_hesap FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
									euro_hesap = @db.execute "SELECT euro_hesap FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"

									arr = ["tl_hesap"]
									if tl_hesap2[0][0]>=0
										arr.push("tl2_hesap")
									end
									if usd_hesap[0][0]>=0
										arr.push("usd_hesap")
									end
									if euro_hesap[0][0]>=0
										arr.push("euro_hesap")
									end
									list_dovizfrom = list_box items: [arr[0], arr[1] , arr[2] , arr[3]] , margin:[25,0,0,0] 

									para "Tutar : " , stroke: white , size: "x-small" , align: "center" , margin:[0,20,0,0] , weight:"bold"
									list_dovizfromline = edit_line  margin:[25,4,0,0] , width:"84%"

									para "Transfer Yapılacak Hesap : " , stroke: white , size: "x-small" , align: "center" , margin:[0,20,0,0] , weight:"bold"
									list_dovizto = list_box items: [arr[0], arr[1] , arr[2] , arr[3]] , margin:[25,4,0,2] 

									accept_transfer = button "Gönder" , width:"40%" , height:"13%" , margin:[80,20,0,0]

									x = image "./logo/back.png" , width: 50 , height: 50
									x.move("44%" , 285)
									x.click{icons.clear do 
										procces
									end}

									accept_transfer.click{
										kont = @db.execute "SELECT #{list_dovizfrom.text} FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"

										if list_dovizfromline.text.to_i > kont[0][0]
											list_dovizfromline.text = "Yetersiz Bakiye"
										elsif list_dovizfromline.text.to_i <= 0
											list_dovizfromline.text = "Geçersiz İşlem"	
										else
										@db.execute "UPDATE user SET #{list_dovizfrom.text} = #{list_dovizfrom.text} - #{list_dovizfromline.text.to_i} WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
										@db.execute "UPDATE user SET #{list_dovizto.text} = #{list_dovizto.text} + #{list_dovizfromline.text.to_i} WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
										list_dovizfromline.text = "Paranız Hesabınıza Aktarıldı"
										end
									}
									end 					
									}
									para_gonder.click{
									icons.clear do  para "PARA GÖNDER" , stroke: white , size: "medium" , align: "center" , margin:[0,0,0,1]
									para "Gönderilecek Kişinin Adı : " , stroke: white , size: "x-small" , align: "center" , margin:[0,5,0,0], weight:"bold"
									ad = edit_line  margin:[25,3,0,0] , width:"84%"

									para "Gönderilecek Kişinin Soyadı : " , stroke: white , size: "x-small" , align: "center" , margin:[0,5,0,0], weight:"bold"
									soyad = edit_line  margin:[25,3,0,0] , width:"84%"

									para "Gönderilecek Kişinin TC NO : " , stroke: white , size: "x-small" , align: "center" , margin:[0,5,0,0], weight:"bold"
									tc = edit_line  margin:[25,3,0,0] , width:"84%"

									para "Gönderilecek Tutar : " , stroke: white , size: "x-small" , align: "center" , margin:[0,5,0,0], weight:"bold"
									list_doviztoamount = edit_line  margin:[25,3,0,0] , width:"84%"

									accept_transfer = button "Gönder" , width:"40%" , height:"10%" , margin:[80,10,0,0]
									gonderim = para "" , margin:["34%",18,0,0] , stroke:white , weight:"bold" , size:"x-small"  
									

									x = image "./logo/back.png" , width: 50 , height: 50
									x.move("44%" , 285)
									x.click{icons.clear do 
										procces
									end}

									accept_transfer.click{
									person = @db.execute "SELECT tc FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
									count = @db.execute "SELECT tc FROM user WHERE ad = '#{ad.text}' AND soyad = '#{soyad.text}' AND tc = '#{tc.text}'"													
									gonderim.replace "Yanlış Bilgi"

									if ad.text =="" || soyad.text=="" || tc.text=="" || list_doviztoamount.text=="" 
										gonderim.replace "Boş Alanları Doldurunuz"
									elsif list_doviztoamount.text.to_i<=0
										gonderim.replace "Geçerli Bir Miktar Giriniz"
									elsif person[0][0] == count[0][0]
										gonderim.replace "Kendine Para Gönderemezsin"
									elsif count[0][0].to_s.length == 11
										bakiye = @db.execute "SELECT tl_hesap FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
										if bakiye[0][0]>list_doviztoamount.text.to_i
										gonderim.replace "Paranız Gönderildi"
										@db.execute "UPDATE user SET tl_hesap = tl_hesap - #{list_doviztoamount.text.to_i} WHERE tc = #{@cont_tc}"
										@db.execute "UPDATE user SET tl_hesap = tl_hesap + #{list_doviztoamount.text.to_i} WHERE tc = #{tc.text.to_i}"
										detail.clear do amount end
										elsif bakiye[0][0]<list_doviztoamount.text.to_i
										gonderim.replace "Yetersiz Bakiye"
										end
									end
									}
									end
									}
									hesap_bilgi.click{
										info = @db.execute "SELECT ad , soyad , tc , mail , parola , bakiye , tl_hesap , tl2_hesap , usd_hesap , euro_hesap FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"

										icons.clear do  para "Hesap Bilgileri" , stroke: white , size: "medium" , align: "center" , margin:[0,0,0,1] , weight:"bold"
										para "Adınız                     :    ", info[0][0] , stroke: white , size: "x-small" , align: "left" , margin:[0,10,0,0], weight:"bold"
										para "Soyadınız              :    ", info[0][1] , stroke: white , size: "x-small" , align: "left" , margin:[0,10,0,0], weight:"bold"
										para "Tc                           :    " , info[0][2] , stroke: white , size: "x-small" , align: "left" , margin:[0,10,0,0], weight:"bold"
										para "Mail                        :    " , info[0][3] , stroke: white , size: "x-small" , align: "left" , margin:[0,10,0,0], weight:"bold"
										para "Toplam Bakiye    :    ", info[0][5] , stroke: white , size: "x-small" , align: "left" , margin:[0,10,0,0] , weight:"bold"
										if info[0][6] > 0
												para "TL Hesabı        :    ", info[0][6] , stroke: white , size: "x-small" , align: "left" , margin:[0,10,0,0] , weight:"bold"
										end
										if info[0][7] > -1
												para "2. TL Hesabı        :    ", info[0][7] , stroke: white , size: "x-small" , align: "left" , margin:[0,10,0,0] , weight:"bold"
										end
										if info[0][8] > -1
												para "USD Hesabı        :    ", info[0][8] , stroke: white , size: "x-small" , align: "left" , margin:[0,10,0,0] , weight:"bold"
										end
										if info[0][9] > -1
												para "EURO Hesabı     :    ", info[0][9] , stroke: white , size: "x-small" , align: "left" , margin:[0,10,0,0] , weight:"bold"
										end
										mail_sender = button "Bilgileri Mail Adresime Gönder" , margin:[30,8,0,0] , width:"85%" , height:"10%"
										mail_sender_info = para "" , margin:["27%",10,0,0] , stroke:white , weight:"bold" , size:"x-small" 
										
										x = image "./logo/back.png" , width: 40 , height: 40
										x.move("44%" , 300)
										x.click{icons.clear do 
										procces
										end}

										mail_sender.click{
														mail_sender_info.replace "Bilgileriniz Gönderildi"

														require 'mail'

														options = { :address              	  => "smtp.gmail.com",
														                :port                 => 587,
														                :user_name            => 'cagatayrubyproject@gmail.com',
														                :password             => 'Qweasd12',
														                :authentication       => 'plain',
														                :enable_starttls_auto => true  }

														    Mail.defaults do
														      delivery_method :smtp, options
														    end

														    Mail.deliver do
														      to info[0][3]
														      from 'cagatayrubyproject@gmail.com'
														      subject 'Hesap Bilgileriniz: '
														      body "Adınız        : #{info[0][0]}\n
														      		Soyadınız 	  : #{info[0][2]}\n
														      		Tc            : #{info[0][3]}\n
														      		Toplam Bakiye : #{info[0][5]}\n
														      		TL Hesabı     : #{info[0][6]}\n
														      		2. TL Hesabı  : #{info[0][7]}\n
														      		USD Hesabı    : #{info[0][8]}\n
														      		EURO Hesabı   : #{info[0][9]}\n"
														    end
														 }
										end
									}
							end
							flow do 
									para "Transfer Yap" , margin:[5,5,0,0] , size: "xx-small" , stroke: white , weight:"bold"
									para "Para Gonder" , margin:[20,5,0,0] , stroke: white , size: "xx-small" , weight:"bold"
									para "Hesap Bilgisi" , margin:[28,5,0,0] , stroke: white , size: "xx-small", weight:"bold"
							end
							flow margin:[0,20,0,0] do 
									faiz = image "./logo/faiz.png" , margin:[0,0,0,0]
									exit_system = image "./logo/exit.png" , margin:[25,0,0,0]
									faiz.click{
										icons.clear do  para "Paranı Faize Yatır" , stroke: white , size: "medium" , align: "center" , margin:[0,0,0,1], weight:"bold"
										para "Mevcut Faiz Oranlarımız TL    : 10 Saniye %3 \nMevcut Faiz Oranlarımı USD   : 10 Saniye %1 \nMevcut Faiz Oranlarımı EURO : 10 Saniye %1" , size:"xx-small" ,stroke:white , margin:[0,10,0,0] , weight:"bold"

										tl_hesap = @db.execute "SELECT tl_hesap FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
										tl2_hesap = @db.execute "SELECT tl2_hesap FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
										usd_hesap = @db.execute "SELECT usd_hesap FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
										euro_hesap = @db.execute "SELECT euro_hesap FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"

										paralar = ["tl_hesap"]
										if tl2_hesap[0][0]>=0
											paralar.push("tl2_hesap")
										end
										if usd_hesap[0][0]>=0
											paralar.push("usd_hesap")
										end
										if euro_hesap[0][0]>=0
											paralar.push("euro_hesap")
										end
										para "Faize Yatırmak İçin Hesap Seçiniz : " , stroke: white , size: "x-small" , align: "center" , margin:[0,10,0,0], weight:"bold"
										hesaplar = list_box items: [paralar[0] , paralar[1] , paralar[2]  , paralar[3]] , margin:[25,10,0,0] 
										bakiye_goruntule =  button "Bakiye Görüntüle" , margin:[65,15,0,0] , width:"50%" , height:"12%", weight:"bold"
										bakiye_miktar = para "Bakiye : ", margin:[65,15,0,0] , stroke:white , weight:"bold" , size:"x-small" 	, weight:"bold"
										faiz_miktar = para "Faizli Bakiye : ", margin:[65,10,0,0] , stroke:white , weight:"bold" , size:"x-small" 	, weight:"bold"
										bakiye_goruntule.click{
												tl_hesap = @db.execute "SELECT tl_hesap FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
												tl2_hesap = @db.execute "SELECT tl2_hesap FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
												usd_hesap = @db.execute "SELECT usd_hesap FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"
												euro_hesap = @db.execute "SELECT euro_hesap FROM user WHERE ad = '#{@cont_name}' AND tc = #{@cont_tc} AND parola = '#{@cont_parola}'"

												if hesaplar.text == "tl_hesap"
												bakiye_miktar.replace "Bakiye : " , tl_hesap[0][0].to_i
												faiz_miktar.replace "Faizli Bakiye : " , (tl_hesap[0][0].to_i + ((tl_hesap[0][0].to_i/100)*3))
												end
												if hesaplar.text == "tl2_hesap"
												bakiye_miktar.replace "Bakiye : " , tl2_hesap[0][0].to_i
												faiz_miktar.replace "Faizli Bakiye : " , (tl2_hesap[0][0].to_i + ((tl2_hesap[0][0].to_i/100)*3))
												end
												if hesaplar.text == "usd_hesap"
												bakiye_miktar.replace "Bakiye : " , usd_hesap[0][0].to_i
												faiz_miktar.replace "Faizli Bakiye : " , (usd_hesap[0][0].to_i + (usd_hesap[0][0].to_i/100))
												end
												if hesaplar.text == "euro_hesap"
												bakiye_miktar.replace "Bakiye : " , euro_hesap[0][0].to_i
												faiz_miktar.replace "Faizli Bakiye : " , (euro_hesap[0][0].to_i + (euro_hesap[0][0].to_i/100))
												end
									}
									faize_yatir =  button "Faize Yatır" , margin:[65,5,0,0] , width:"50%" , height:"12%"
									sonuc = para "" , stroke:white , size:"x-small" , weight:"bold" , margin:[65,10,0,0]
									x = image "./logo/back.png" , width: 45 , height: 45
										x.move("44%" , 293)
										x.click{icons.clear do 
										procces
										end}
									faize_yatir.click{ 
													t1 = Time.now
													if hesaplar.text.length > 0
													while true
													if Time.now > t1+10
														if hesaplar.text == "tl_hesap"
														sonuc.replace "Yeni Bakiye : " , (tl_hesap[0][0].to_i + ((tl_hesap[0][0].to_i/100)*3))
														@db.execute "UPDATE user SET tl_hesap = tl_hesap + #{(tl_hesap[0][0].to_i/100)*3} WHERE tc = #{@cont_tc}"
														detail.clear do amount end 
														end
														if hesaplar.text == "tl2_hesap"
														sonuc.replace "Yeni Bakiye : " , (tl2_hesap[0][0].to_i + ((tl2_hesap[0][0].to_i/100)*3))
														@db.execute "UPDATE user SET tl2_hesap = tl2_hesap + #{(tl2_hesap[0][0].to_i/100)*3} WHERE tc = #{@cont_tc}"
														detail.clear do amount end 
														end
														if hesaplar.text == "usd_hesap"
														sonuc.replace "Yeni Bakiye Bakiye : " , (usd_hesap[0][0].to_i + (usd_hesap[0][0].to_i/100))
														@db.execute "UPDATE user SET usd_hesap = usd_hesap + #{(usd_hesap[0][0].to_i/100)} WHERE tc = #{@cont_tc}"
														detail.clear do amount end 
														end
														if hesaplar.text == "euro_hesap"
														sonuc.replace "Yeni Bakiye : " , (euro_hesap[0][0].to_i + (euro_hesap[0][0].to_i/100))
														@db.execute "UPDATE user SET euro_hesap = euro_hesap + #{(euro_hesap[0][0].to_i/100)} WHERE tc = #{@cont_tc}"
														detail.clear do amount end 
														end
														break
													end
													end
													end
													}

									end
									}
									exit_system.click{icons.clear do exit end}
							end
							flow do para "Faiz Al" , margin:[15,5,0,0] , size: "xx-small" , stroke: white 
									para "Kapat" , margin:[70,5,0,0] , stroke: white , size: "xx-small" 
							end
                 			end
                 			end
                 		end
                 		procces
                 end
                 end
    			 end
    }
   end
   ana
end


    @main = stack width: "50%" , height:"100%" do
      def register_user
      background "#363a81"
      cumle = para "Bir Hesap Oluştur" , stroke: white , size: "medium" , align: "center" , margin:[0,"7%",0,0], weight:"bold"
      para "Ad : " , stroke: white , size: "small" , margin:["5%","7%",0,0], weight:"bold"
      name = edit_line width: "58%" 
      name.move("40%","17%")

      para "Soyad : " , stroke: white , size: "small" , margin:["5%","7%",0,0], weight:"bold"
      surname = edit_line width: "58%"
      surname.move("40%","27%")

      para "TC No : " , stroke: white , size: "small" , margin:["5%","7%",0,0], weight:"bold"
      tc = edit_line width: "58%"
      tc.move("40%","38%")

      para "Mail Adresi : " , stroke: white , size: "small" , margin:["5%","7%",0,0], weight:"bold"
      mail = edit_line width: "58%"
      mail.move("40%","49%")

      para "Şifre : " , stroke: white , size: "small" , margin:["5%","7%",0,0], weight:"bold"
      sifre = edit_line width: "58%" , secret:"true"
      sifre.move("40%","60%")

      para "Bilgilerinizi Onaylıyor Musunuz ? " , size: "small" , stroke:white , margin:["5%","6%",0,0], weight:"bold"
      check_box = check;  
      check_box.move("91%","70%")
      check_box.width = 100

      kayıt_ol = button "Kaydı Tamamla" , margin:["5%","4%",0,0] 
   	  kayıt_ol.style width: "92%"
      kayıt_ol.style height: "7%"

      info = para  "" , weight:"bold", stroke: white , size: "small", margin:["20%","7%",0,0] 
      kayıt_ol.click {
      		loop do
      		if name.text=="" || name.text=="Gecerli Bir Isim Giriniz"
   				info.replace "Gecerli Bir Isim Giriniz"
   				break
   			elsif surname.text=="" || surname.text=="Gecerli Bir Soyisim Giriniz"
   				info.replace "Gecerli Bir Soyisim Giriniz"
   				break 
   			elsif tc.text=="" || tc.text=="Gecerli Bir Tc No Giriniz" || tc.text.length != 11 || tc.text == "Bu Tc Sistemde Mevcut"
   				info.replace "Gecerli Bir Tc No Giriniz"
   				break
   			elsif mail.text=="" || mail.text=="Gecerli Bir Mail Adresi Giriniz"
   				info.replace "Gecerli Bir Mail Adresi Giriniz"
   				break 
   			elsif sifre.text=="" || sifre.text=="Gecerli Bir Sifre Giriniz"
   				info.replace "Minimum 6 Karakterli Bir Şifre Giriniz"
   				break
   			elsif check_box.checked?()==false
   				break
   			end
   			if true 
				@db.execute("INSERT INTO user (ad , soyad , tc , mail , parola , bakiye , tl_hesap , tl2_hesap , usd_hesap , euro_hesap) VALUES ( '#{name.text}' , '#{surname.text}' , #{tc.text} , '#{mail.text}' , '#{sifre.text}' , 0 , 0 , -1 , -1 , -1)")
	   			info.replace "Kayıt Başarılı Giriş Yapınız"
	   			break
	   		end
	   		end
		}
	end
	register_user
end
    end
  end


