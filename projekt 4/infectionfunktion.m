function vektor = infectionfunktion(t,regen,activation,deathnormal,infection,latent,endlatent,recycle,deathhiv,production,VERL)
%VERL
vektor = [production*VERL(2)-recycle*VERL(1); (1-latent)*infection*VERL(3)*VERL(1)+endlatent*VERL(4)-deathhiv*VERL(2); regen*activation-deathnormal*VERL(3)-infection*VERL(3)*VERL(1); latent*infection*VERL(3)*VERL(1)-deathnormal*VERL(4)-endlatent*VERL(4)];
end