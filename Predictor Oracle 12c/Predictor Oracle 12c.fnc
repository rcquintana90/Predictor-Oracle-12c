create or replace function Predictor(p_num   varchar2,
                                     p_fecha varchar2,
                                     p_hora  varchar2) return varchar2 is

  -- Function Pico y Placa Predictor Quito 
  -- Using PLSQL in Oracle Database 12c Enterprise Edition
  -- Created By Roberto Quintana

  respuesta     varchar2(25);
  resultado     number(1) := 1;
  ultimo_digito number := SUBSTR(p_num, LENGTH(p_num), 1);
  dia           number := to_char(to_date(p_fecha, 'dd/MM/yyyy'), 'D');
  hora          varchar2(5) := p_hora;
  q             number := 1;
  w             number := 2;
  contador      number := 1;
  type dias is varray(4) of varchar2(20);
  array dias := dias('Lunes', 'Martes', 'Miercoles', 'Jueves');
begin

  if (dia = 6 or dia = 0) then
  
    resultado := 1;
  
  elsif ((ultimo_digito = 0) or (ultimo_digito = 9)) then
  
    if (dia = 5) then
    
      resultado := 0;
    
    end if;
  else
  
    for i in 1 .. array.count loop
    
      if ((ultimo_digito = q) or (ultimo_digito = w)) then
        contador := i;
      
      end if;
      q := q + 2;
      w := w + 2;
    
    end loop;
  
  end if;

  if (dia = contador) then
  
    if (hora >= '07:00' and hora <= '09:30') then
      resultado := 0;
    else
      if (hora >= '16:00' and hora <= '19:30') then
        resultado := 0;
      else
        resultado := 1;
      end if;
    
    end if;
  
  end if;

  if resultado = 1 then
    respuesta := 'The car can circulate!';
  else
    respuesta := 'The car can not circulate';
  end if;

  return respuesta;

exception
  when others then
    raise_application_error(-20506, 'Error' || sqlerrm);
end;
/
