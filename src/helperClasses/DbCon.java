package helperClasses;

import java.sql.Connection;
import java.sql.ResultSet;

public class DbCon {
	ResultSet rst;
	public ResultSet getRst() {
		return rst;
	}
	public void setRst(ResultSet rst) {
		this.rst = rst;
	}
	public Connection getCntcn() {
		return cntcn;
	}
	public void setCntcn(Connection cntcn) {
		this.cntcn = cntcn;
	}
	Connection cntcn;
	

}
