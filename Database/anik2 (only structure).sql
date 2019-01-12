-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 28, 2016 at 09:17 PM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 5.6.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `anik2`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddAdditionalUserData` (IN `Puserid` VARCHAR(256), IN `Pfirstname` VARCHAR(50), IN `Plastname` VARCHAR(50), IN `Psex` INT(3), IN `Pversitydeptid` INT)  NO SQL
UPDATE users SET users.FirstName = pfirstname,
                 users.lastname = plastname,
                 users.sex = psex,
                 users.versityDeptId = Pversitydeptid 
                 where users.id = puserid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddAttendance` (IN `mrid` INT(11), IN `date` DATE, IN `pr` TINYINT(1))  NO SQL
INSERT INTO attendence VALUES (null, mrid, date, pr)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddAttendanceSection` (IN `tcid` INT(11), IN `start` INT(11), IN `end` INT(11), IN `mark` INT(11), IN `default` BOOLEAN)  NO SQL
INSERT INTO attendencesection VALUES(null, start, end, mark, tcid, default)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddCource` (IN `prefix` TEXT, IN `cno` INT(11), IN `postfix` TEXT, IN `ct` TEXT, IN `vdid` INT(11), IN `crd` FLOAT(11))  NO SQL
INSERT INTO course VALUES(null, prefix, cno, postfix, ct, vdid, crd)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddDegreeSessionYearTerm` (IN `did` INT(11), IN `sid` INT(11), IN `yid` INT(11), IN `tid` INT(11))  NO SQL
INSERT INTO degreesessionyearterm VALUES(null, did, sid, yid, tid)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddMark4attByMsidSid` (IN `mcid` INT(11), IN `sid` VARCHAR(16))  NO SQL
INSERT INTO mark VALUES(null, mcid, sid, null)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddMark4CtAssByMsidSid` (IN `msid` INT(11), IN `sid` INT(11))  NO SQL
INSERT INTO mark VALUES(null, msid, sid, null)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddMarksectionForAss` (IN `tcid` INT(11), IN `snid` INT(11), IN `msmark` INT(11))  NO SQL
INSERT INTO marksection VALUES(null, tcid, snid, msmark)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddMarkSectionForAttendance` (IN `tcid` INT(11))  NO SQL
INSERT INTO marksection VALUES (NULL, tcid, 1, 10)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddMarksectionForCt` (IN `tcid` INT(11), IN `snid` INT(11), IN `msmark` INT(11))  NO SQL
INSERT INTO marksection VALUES (null, tcid, snid, msmark)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddSectionName` (IN `name` TEXT)  NO SQL
INSERT INTO sectionname VALUES(null,name)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addStudent` (IN `sid` VARCHAR(256), IN `btc` TEXT, IN `uid` VARCHAR(256))  NO SQL
INSERT INTO student VALUES(null, sid, btc, uid)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddStudentUserCourse` (IN `tcid` INT(11), IN `sid` INT(11))  NO SQL
INSERT INTO `studentusercourse` (`id`, `teachercourseid`, `studentid`, `isconfirmed`) VALUES (NULL, tcid, sid, '0')$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addTeacher` (IN `UId` VARCHAR(128), IN `did` INT, IN `sid` INT)  NO SQL
INSERT INTO teacher VALUES(null, Uid, did, sid)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddTeacherCource` (IN `uid` INT(11), IN `did` INT(11), IN `cid` INT(11))  NO SQL
INSERT INTO teachercourse VALUES(null, uid, did, cid, 0)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ClosedTeacherCourseByTidCid` (IN `tid` INT(11), IN `cid` INT(11))  NO SQL
UPDATE teachercourse SET teachercourse.isclosed = 1
WHERE teachercourse.teacherId=tid
AND teachercourse.courseId =cid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CountAttendanceSectionIdByTcid` (IN `tcid` INT(11))  NO SQL
SELECT COUNT(attendencesection.id) FROM attendencesection 
WHERE attendencesection.teacherCourceId = tcid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CountAttendanceSectionIdByTcidAsDefault` (IN `tcid` INT(11))  NO SQL
SELECT COUNT(attendencesection.id) FROM attendencesection 
WHERE attendencesection.teacherCourceId = tcid	
AND attendencesection.asDefault = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `countCtAssByTCID` (IN `tcid` INT(11))  NO SQL
select COUNT(marksection.id) FROM marksection 
WHERE marksection.sectionNameId != 1
AND marksection.teacherCourseId = tcid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CountStudentsByTCID` (IN `tcid` INT(11))  NO SQL
SELECT COUNT(studentusercourse.id) FROM studentusercourse 
WHERE studentusercourse.teachercourseid = tcid
AND studentusercourse.isconfirmed = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteMarkByMsidSid` (IN `msid` INT(11), IN `sid` INT(11))  NO SQL
DELETE FROM mark 
WHERE mark.markSectiontId = msid
AND mark.studentId = sid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteStudentCourseBySCID` (IN `scid` INT(11))  NO SQL
DELETE FROM studentusercourse WHERE studentusercourse.id = scid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeletTeachCourseByTcid` (IN `Tcid` INT(11))  NO SQL
DELETE FROM teachercourse WHERE teachercourse.id = tcid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GeAllDatesPresentsByTcidSid` (IN `tcid` INT(11), IN `sid` INT(11))  NO SQL
SELECT attendence.date as dateColumn, attendence.present FROM attendence
INNER JOIN mark on mark.id =attendence.markId
INNER JOIN marksection on marksection.id = mark.markSectiontId
WHERE marksection.teacherCourseId = tcid
AND mark.studentId = sid
ORDER BY dateColumn$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllCourselListByUserId` (IN `uid` VARCHAR(256))  NO SQL
SELECT teachercourse.id, course.prefix, course.course_no, course.course_tittle, course.postfix, teachercourse.isclosed, session.session FROM teachercourse
INNER JOIN course on teachercourse.courseId = course.id
INNER JOIN degreesessionyearterm on teachercourse.DegreeSessionYearTermId = degreesessionyearterm.id
INNER JOIN session on degreesessionyearterm.sessionId = session.id
INNER JOIN teacher on teacher.id = teachercourse.teacherId
WHERE teacher.UserId = uid
ORDER BY course.course_no$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllCrourseNameBySessionIDTeacherID` (IN `tid` INT(11), IN `sid` INT)  NO SQL
SELECT teachercourse.id, course.prefix, course.course_no, course.course_tittle, course.postfix FROM teachercourse
INNER JOIN degreesessionyearterm 
on degreesessionyearterm.id = teachercourse.DegreeSessionYearTermId
INNER JOIN session on session.id = degreesessionyearterm.sessionId
INNER JOIN course on course.id = teachercourse.courseId
WHERE session.id = sid AND teachercourse.teacherId = tid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllCtAssByTCID` (IN `tcid` INT(11))  NO SQL
SELECT marksection.id, marksection.sectionNameId, 
sectionname.name FROM marksection
INNER JOIN sectionname on marksection.sectionNameId = sectionname.id
WHERE marksection.sectionNameId != 1
AND marksection.teacherCourseId =tcid
ORDER BY marksection.sectionNameId$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllCtAssNameMarkByTcidSid` (IN `tcid` INT(11), IN `sid` INT(11))  NO SQL
SELECT marksection.sectionNameId, sectionname.name, mark.mark FROM marksection
INNER JOIN sectionname on sectionname.id = marksection.sectionNameId
INNER JOIN mark on mark.markSectiontId = marksection.id
WHERE marksection.teacherCourseId =tcid
AND marksection.sectionNameId != 1
AND mark.studentId = sid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllCTitleSessionBySID` (IN `sid` VARCHAR(128))  NO SQL
SELECT course.prefix, course.course_no, course.course_tittle, course.postfix, session.session, teachercourse.id FROM course
INNER JOIN teachercourse on teachercourse.courseId = course.id
INNER JOIN studentusercourse on 
studentusercourse.teachercourseid = teachercourse.id
INNER JOIN degreesessionyearterm on 
degreesessionyearterm.id = teachercourse.DegreeSessionYearTermId
INNER JOIN session on session.id = degreesessionyearterm.sessionId
WHERE studentusercourse.studentid = sid
AND studentusercourse.isconfirmed = 1
ORDER BY course.course_no$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllDept` ()  NO SQL
SELECT dept.id, dept.name FROM dept$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllDesignation` ()  NO SQL
SELECT designation.id, designation.designation as name from designation$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllDgree` ()  NO SQL
SELECT degree.id, degree.levelName FROM degree$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllSalutaion` ()  NO SQL
SELECT salutation.id,salutation.salutation as name FROM salutation$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllSession` ()  NO SQL
SELECT session.id, session.session FROM session$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllTerm` ()  NO SQL
SELECT term.id, term.term FROM term$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllVersity` ()  NO SQL
SELECT versity.id , versity.name FROM versity$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllYear` ()  NO SQL
SELECT year.id, year.year FROM year$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetApprovedStudentByTeacherCourseId` (IN `tcid` INT(11))  NO SQL
SELECT studentusercourse.id, student.studentId, users.FirstName, users.LastName FROM studentusercourse
INNER JOIN student on studentusercourse.studentid = student.id
INNER JOIN users on student.userid = users.Id
WHERE studentusercourse.teachercourseid = tcid
AND studentusercourse.isconfirmed = 1
ORDER BY student.studentId$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAttendanceAsdefaultBytcid` (IN `tcid` INT(11))  NO SQL
SELECT attendencesection.id FROM attendencesection
WHERE attendencesection.teacherCourceId =tcid
AND attendencesection.asDefault = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAttendanceIdByMarkIdDate` (IN `mrid` INT(11), IN `dt` DATE)  NO SQL
SELECT attendence.id FROM attendence
WHERE attendence.markId = mrid AND attendence.date = dt LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAttendanceMSIdSidByTCId` (IN `tcid` INT(11))  NO SQL
SELECT mark.id, mark.markSectiontId, mark.studentId, 
student.studentId as s FROM mark
INNER JOIN marksection on marksection.id = mark.markSectiontId
INNER JOIN student on 	student.id = mark.studentId
WHERE marksection.teacherCourseId = tcid
AND marksection.sectionNameId = 1
ORDER BY s$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAttendancePersentaheByTCID` (IN `tcid` INT(11))  NO SQL
SELECT marksection.sectionPercentage FROM marksection
WHERE marksection.sectionNameId = 1 AND
marksection.teacherCourseId = tcid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAttendanceSecListByTCID` (IN `tcid` INT(11))  NO SQL
SELECT ac.id, ac.start, ac.end, ac.mark FROM attendencesection as ac
WHERE ac.teacherCourceId = tcid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAttendanceSectionByTCID` (IN `tcid` INT(11))  NO SQL
SELECT attendancesection.numberOfSection FROM attendancesection WHERE attendancesection.teacherCourseId = tcid LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAttMarkByTCID` (IN `tcid` INT(11))  NO SQL
SELECT marksection.sectionPercentage FROM marksection
WHERE marksection.sectionNameId = 1
AND marksection.teacherCourseId = tcid
LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBatchByUserId` (IN `uid` VARCHAR(256))  NO SQL
SELECT student.batch FROM student WHERE student.userid = uid LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetClosedCrourseNameBySessionIDTeacherID` (IN `tid` INT(11), IN `sid` INT(11))  NO SQL
SELECT course.id, course.prefix, course.course_no, course.course_tittle, course.postfix FROM teachercourse
INNER JOIN degreesessionyearterm 
on degreesessionyearterm.id = teachercourse.DegreeSessionYearTermId
INNER JOIN session on session.id = degreesessionyearterm.sessionId
INNER JOIN course on course.id = teachercourse.courseId
WHERE session.id = sid AND teachercourse.teacherId = tid
AND teachercourse.isclosed = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCorseNameByStudentId` (IN `sid` INT(11))  NO SQL
SELECT sc.id, sc.isconfirmed, course.prefix, course.course_no, course.postfix, course.course_tittle FROM studentusercourse AS sc
INNER JOIN teachercourse on teachercourse.id = sc.teachercourseid
INNER JOIN course on course.id =teachercourse.courseId
WHERE sc.studentid = sid ORDER BY course.course_no$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCourseByVersityDeptId` (IN `vdid` INT)  NO SQL
SELECT course.course_tittle, course.id FROM course WHERE course.versityDeptId = vdid ORDER BY course.course_no$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCourseListByUserID` (IN `uid` VARCHAR(256))  NO SQL
SELECT teachercourse.courseId FROM teachercourse
INNER JOIN teacher
on teacher.id = teachercourse.teacherId
WHERE teacher.UserId = uid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCourselListByTeacherId` (IN `tid` INT(11))  NO SQL
SELECT teachercourse.id, course.prefix, course.course_no, course.course_tittle, course.postfix, session.session FROM teachercourse
INNER JOIN course on teachercourse.courseId = course.id
INNER JOIN degreesessionyearterm on teachercourse.DegreeSessionYearTermId = degreesessionyearterm.id
INNER JOIN session on degreesessionyearterm.sessionId = session.id
WHERE teachercourse.teacherId =tid
AND teachercourse.isclosed = 0
ORDER BY course.course_no$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCouserPreFixCodeNameByVersityDeptId` (IN `vdid` INT(11))  NO SQL
SELECT course.id, course.prefix ,course.course_no, course.course_tittle, course.postfix FROM course
WHERE course.versityDeptId = vdid ORDER BY course.course_no$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCtAssMSIdSidByTCId` (IN `tcid` INT)  NO SQL
SELECT mark.id, mark.markSectiontId, mark.studentId, 
student.studentId as s FROM mark
INNER JOIN marksection on marksection.id = mark.markSectiontId
INNER JOIN student on 	student.id = mark.studentId
WHERE marksection.teacherCourseId = tcid
AND marksection.sectionNameId != 1
ORDER BY s$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDegreeSessionYearTermIdBYAllIndex` (IN `did` INT(11), IN `sid` INT(11), IN `yid` INT(11), IN `tid` INT(11))  NO SQL
SELECT degreesessionyearterm.id FROM degreesessionyearterm WHERE degreesessionyearterm.degreeId = did AND degreesessionyearterm.sessionId = sid AND degreesessionyearterm.yearId = yid AND degreesessionyearterm.termId = tid LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDeptByVdId` (IN `vdid` INT(11))  NO SQL
SELECT dept.name  
FROM versitydept 
INNER JOIN dept
ON versitydept.deptId = dept.id
WHERE versitydept.id = vdid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getDeptByVersityId` (IN `pid` INT)  NO SQL
SELECT dept.id, dept.name FROM dept INNER JOIN versitydept ON dept.id = versitydept.deptId WHERE versitydept.versityId = pid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDesignationIDByUserId` (IN `uid` VARCHAR(256))  NO SQL
SELECT teacher.designationid FROM teacher
WHERE teacher.UserId = uid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetLastInsertIdOfMarkSection4AssByTcid` (IN `tcid` INT(11))  NO SQL
SELECT MAX(marksection.id) FROM marksection
WHERE marksection.teacherCourseId = tcid
AND marksection.sectionNameId >= 7$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetLastInsertIdOfMarkSection4CtAssByTcid` (IN `tcid` INT(11))  NO SQL
SELECT MAX(marksection.id) FROM marksection
WHERE marksection.teacherCourseId = tcid
AND marksection.sectionNameId != 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetLastInsertIdOfSectionName` ()  NO SQL
SELECT MAX(sectionname.id) FROM sectionname LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMarkSectionIdForAttendenceByTCID` (IN `tcid` INT(11))  NO SQL
SELECT marksection.id FROM marksection
WHERE marksection.teacherCourseId = tcid
AND marksection.sectionNameId = 1 LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMarksectionIdForCtByTcid` (IN `tcid` INT(11))  NO SQL
select marksection.id FROM marksection 
WHERE marksection.sectionNameId >= 2
AND marksection.sectionNameId <= 6
AND marksection.teacherCourseId = tcid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMarkSectionParcentageByTCID` (IN `tcid` INT(11))  NO SQL
SELECT marksection.sectionPercentage FROM marksection 
WHERE marksection.teacherCourseId = tcid
LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetNotApprovedStudentByTeacherCourseId` (IN `tcid` INT(11))  NO SQL
SELECT studentusercourse.id, student.studentId, users.FirstName, users.LastName FROM studentusercourse
INNER JOIN student on studentusercourse.studentid = student.id
INNER JOIN users on student.userid = users.Id
WHERE studentusercourse.teachercourseid = tcid
AND studentusercourse.isconfirmed = 0
ORDER BY student.studentId$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetOpenedCrourseNameBySessionIDTeacherID` (IN `tid` INT(11), IN `sid` INT(11))  NO SQL
SELECT course.id, course.prefix, course.course_no, course.course_tittle, course.postfix FROM teachercourse
INNER JOIN degreesessionyearterm 
on degreesessionyearterm.id = teachercourse.DegreeSessionYearTermId
INNER JOIN session on session.id = degreesessionyearterm.sessionId
INNER JOIN course on course.id = teachercourse.courseId
WHERE session.id = sid 
AND teachercourse.teacherId = tid
AND teachercourse.isclosed = 0$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPresentByAttnId` (IN `atnid` INT(11))  NO SQL
SELECT attendence.present FROM attendence
WHERE attendence.id = atnid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSessionByTeacherId` (IN `tid` INT(11))  NO SQL
SELECT DISTINCT session.id, session.session FROM teachercourse 
INNER JOIN degreesessionyearterm 
on teachercourse.DegreeSessionYearTermId = degreesessionyearterm.id
INNER JOIN session 
on degreesessionyearterm.sessionId = session.id
WHERE teachercourse.teacherId = tid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSessionByTeacherIdCourseId` (IN `tid` INT(11), IN `cid` INT(11))  NO SQL
SELECT teachercourse.id, session.session FROM teachercourse 
INNER JOIN degreesessionyearterm 
on teachercourse.DegreeSessionYearTermId = degreesessionyearterm.id
INNER JOIN session 
on degreesessionyearterm.sessionId = session.id
WHERE teachercourse.teacherId = tid 
AND teachercourse.courseId = cid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSidSnameBysid` (IN `sid` INT(11))  NO SQL
SELECT student.studentId, student.batch, 
users.FirstName, users.LastName FROM student
INNER JOIN users on users.id = student.userid
WHERE student.id = sid 
ORDER BY student.studentId$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSidSnameDatePresentByMarkIdSid` (IN `mrid` INT(11))  NO SQL
SELECT mark.id, student.studentId, users.FirstName, 
users.LastName, attendence.date AS dateColumn,  
attendence.present from mark
INNER JOIN student on student.id = mark.studentId
INNER JOIN users on users.Id = student.userid
INNER JOIN attendence on attendence.markId = mark.id
WHERE mark.id = mrid
ORDER BY dateColumn$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSidSnameMarksByMarkIdSid` (IN `mrid` INT)  NO SQL
SELECT mark.id, mark.mark, student.studentId, 
users.FirstName, users.LastName, marksection.sectionPercentage, sectionname.name from mark
INNER JOIN student on student.id = mark.studentId
INNER JOIN users on users.Id = student.userid
INNER JOIN marksection on marksection.id = mark.markSectiontId
INNER JOIN sectionname on sectionname.id = marksection.sectionNameId
WHERE mark.id = mrid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSidSnameMarksMarkIdByMarkSectionID` (IN `mrsid` INT(11))  NO SQL
SELECT mark.id, mark.mark, users.FirstName, users.LastName, student.studentId FROM mark
INNER JOIN marksection on marksection.id = mark.markSectiontId
INNER JOIN student on student.id = mark.studentId
INNER JOIN users on users.Id = student.userid
WHERE marksection.id = mrsid
ORDER BY student.studentId$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStudentCourseIdByTCID` (IN `tcid` INT(11))  NO SQL
SELECT studentusercourse.id FROM studentusercourse
WHERE studentusercourse.teachercourseid = tcid
AND studentusercourse.isconfirmed = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStudentCourseIDbyTeacherCourseIdStudentId` (IN `tcid` INT(11), IN `sid` INT(11))  NO SQL
SELECT studentusercourse.id FROM studentusercourse
WHERE studentusercourse.teachercourseid = tcid 
AND studentusercourse.studentid = sid LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStudentIdByUserId` (IN `uid` VARCHAR(265))  NO SQL
SELECT student.studentId FROM student WHERE student.userid = uid LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStudentTableIdByScid` (IN `scid` INT(11))  NO SQL
SELECT student.id from studentusercourse 
INNER JOIN student on student.id = studentusercourse.studentid
WHERE studentusercourse.id = scid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStudentTableIdByTcid` (IN `Tcid` INT(11))  NO SQL
SELECT studentusercourse.studentid FROM studentusercourse
WHERE studentusercourse.teachercourseid = tcid
AND studentusercourse.isconfirmed = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStudentTableIdByUserId` (IN `uid` VARCHAR(256))  NO SQL
SELECT student.id FROM student WHERE student.userid = uid LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTCIDByTID` (IN `tid` INT(11))  NO SQL
SELECT teachercourse.id FROM teachercourse
WHERE teachercourse.teacherId = tid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTeacherCourceIdByTidDidCid` (IN `uid` INT(11), IN `did` INT(11), IN `cid` INT(11))  NO SQL
SELECT teachercourse.id FROM teachercourse 
WHERE teachercourse.teacherId = uid 
AND teachercourse.DegreeSessionYearTermId = did
AND teachercourse.courseId = cid LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTeacherIdByUserId` (IN `uid` VARCHAR(256))  NO SQL
SELECT teacher.id FROM teacher  WHERE teacher.UserId = uid LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTeacherNameByCourseId` (IN `cid` INT(11))  NO SQL
SELECT DISTINCT teachercourse.teacherId, users.FirstName, users.LastName FROM teachercourse
INNER JOIN teacher ON teachercourse.teacherId = teacher.id
INNER JOIN users ON teacher.UserId = users.Id
WHERE teachercourse.courseId = cid
AND teachercourse.isclosed = 0$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTNameCNameCsBySID` (IN `sid` INT(11))  NO SQL
SELECT studentusercourse.id, users.FirstName, users.LastName, course.prefix, course.course_no, course.postfix, course.course_tittle, studentusercourse.isconfirmed FROM studentusercourse
INNER JOIN teachercourse on teachercourse.id = studentusercourse.teachercourseid
INNER JOIN course on course.id = teachercourse.courseId
INNER JOIN teacher on teachercourse.teacherId = teacher.id
INNER JOIN users on users.Id = teacher.UserId
INNER JOIN student on student.id = studentusercourse.studentid
WHERE student.Id = sid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetVersityByVdID` (IN `vdid` INT(11))  NO SQL
SELECT versity.name  
FROM versitydept 
INNER JOIN versity
ON versitydept.versityId = versity.id
WHERE versitydept.id = vdid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetVersityDeptByAllIndex` (IN `vid` INT(11), IN `did` INT(11))  NO SQL
SELECT versitydept.id FROM versitydept
WHERE versitydept.versityId = vid AND versitydept.deptId = did LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getVersityDeptId` (IN `vid` INT, IN `did` INT)  NO SQL
SELECT versitydept.id FROM versitydept WHERE versitydept.versityId = vid AND versitydept.deptId = did LiMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetVersityDeptIdByUserId` (IN `uid` VARCHAR(128))  NO SQL
SELECT users.versityDeptId FROM users WHERE users.Id = uid LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetVersityDeptIdByVersityIdDeptID` (IN `pversityid` INT, IN `pdeptid` INT)  NO SQL
SELECT versitydept.id FROM versitydept where versitydept.versityId = pversityid and versitydept.deptId = pdeptid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loadAllAssName` ()  NO SQL
SELECT sectionname.id, sectionname.name FROM sectionname
WHERE sectionname.id >= 7$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loadAllCtName` ()  NO SQL
select sectionname.id , sectionname.name FROM sectionname
WHERE sectionname.id >= 2
AND sectionname.id <= 6$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `OpenTeacherCourseByTidCid` (IN `tid` INT(11), IN `cid` INT(11))  NO SQL
UPDATE teachercourse SET teachercourse.isclosed = 0
WHERE teachercourse.teacherId=tid
AND teachercourse.courseId =cid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateAttendanceByAtnIdPresent` (IN `atnid` INT(11), IN `pr` TINYINT(1))  NO SQL
UPDATE attendence SET attendence.present = pr
WHERE attendence.id = atnid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateAttendancemarkperBytcid` (IN `tcid` INT(11), IN `mr` INT(11))  NO SQL
UPDATE marksection 
SET marksection.sectionPercentage = mr
WHERE marksection.teacherCourseId = tcid
AND marksection.sectionNameId = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateAttendanceSectionByid` (IN `id` INT(11), IN `start` INT(11), IN `end` INT(11), IN `mark` INT(11), IN `de` BOOLEAN)  NO SQL
UPDATE attendencesection 
SET attendencesection.start = start,
attendencesection.end = end,
attendencesection.mark = mark,
attendencesection.asDefault = de
WHERE attendencesection.id = id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateAttendanceSectionByTCId` (IN `tcid` INT(11), IN `ns` INT(11))  NO SQL
UPDATE attendancesection SET attendancesection.numberOfSection = ns
WHERE attendancesection.teacherCourseId = tcid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateDesignationIDByUserId` (IN `uid` VARCHAR(256), IN `did` INT(11))  NO SQL
UPDATE teacher SET teacher.designationid =did  WHERE teacher.UserId = uid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateIsConfirmFalseByStudentCourseID` (IN `scid` INT(11))  NO SQL
UPDATE studentusercourse 
SET studentusercourse.isconfirmed = 0
WHERE studentusercourse.id = scid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateIsConfirmTrueByStudentCourseID` (IN `scid` INT(11))  NO SQL
UPDATE studentusercourse 
SET studentusercourse.isconfirmed = 1
WHERE studentusercourse.id = scid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateMarkByMarkID` (IN `mrid` INT(11), IN `mark` INT(11))  NO SQL
UPDATE mark SET mark.mark = mark 
WHERE mark.id = mrid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateMarkSectionByTCID` (IN `tcid` INT(11), IN `mark` INT(11))  NO SQL
UPDATE marksection SET marksection.sectionPercentage = mark
WHERE marksection.teacherCourseId = tcid$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `attendence`
--

CREATE TABLE `attendence` (
  `id` int(11) NOT NULL,
  `markId` int(11) NOT NULL,
  `date` date NOT NULL,
  `present` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `attendencesection`
--

CREATE TABLE `attendencesection` (
  `id` int(11) NOT NULL,
  `start` int(11) NOT NULL,
  `end` int(11) NOT NULL,
  `mark` int(11) NOT NULL,
  `teacherCourceId` int(11) NOT NULL,
  `asDefault` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `id` int(11) NOT NULL,
  `prefix` text NOT NULL,
  `course_no` int(11) NOT NULL,
  `postfix` text,
  `course_tittle` text NOT NULL,
  `versityDeptId` int(11) NOT NULL,
  `credit` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `degree`
--

CREATE TABLE `degree` (
  `id` int(11) NOT NULL,
  `levelName` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `degreesessionyearterm`
--

CREATE TABLE `degreesessionyearterm` (
  `id` int(11) NOT NULL,
  `degreeId` int(11) NOT NULL,
  `sessionId` int(11) NOT NULL,
  `yearId` int(11) DEFAULT NULL,
  `termId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dept`
--

CREATE TABLE `dept` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `designation`
--

CREATE TABLE `designation` (
  `id` int(11) NOT NULL,
  `designation` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mark`
--

CREATE TABLE `mark` (
  `id` int(11) NOT NULL,
  `markSectiontId` int(11) NOT NULL,
  `studentId` int(11) NOT NULL,
  `mark` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `marksection`
--

CREATE TABLE `marksection` (
  `id` int(11) NOT NULL,
  `teacherCourseId` int(11) NOT NULL,
  `sectionNameId` int(11) NOT NULL,
  `sectionPercentage` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `Id` varchar(128) NOT NULL,
  `Name` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `salutation`
--

CREATE TABLE `salutation` (
  `id` int(11) NOT NULL,
  `salutation` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sectionname`
--

CREATE TABLE `sectionname` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE `session` (
  `id` int(11) NOT NULL,
  `session` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `id` int(11) NOT NULL,
  `studentId` varchar(16) NOT NULL,
  `batch` text NOT NULL,
  `userid` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `studentusercourse`
--

CREATE TABLE `studentusercourse` (
  `id` int(11) NOT NULL,
  `teachercourseid` int(11) NOT NULL,
  `studentid` int(11) NOT NULL,
  `isconfirmed` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE `teacher` (
  `id` int(11) NOT NULL,
  `UserId` varchar(256) NOT NULL,
  `salutationid` int(11) NOT NULL,
  `designationid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `teachercourse`
--

CREATE TABLE `teachercourse` (
  `id` int(11) NOT NULL,
  `teacherId` int(11) NOT NULL,
  `DegreeSessionYearTermId` int(11) NOT NULL,
  `courseId` int(11) NOT NULL,
  `isclosed` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `term`
--

CREATE TABLE `term` (
  `id` int(11) NOT NULL,
  `term` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `userclaims`
--

CREATE TABLE `userclaims` (
  `Id` int(11) NOT NULL,
  `UserId` varchar(128) NOT NULL,
  `ClaimType` longtext,
  `ClaimValue` longtext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `userlogins`
--

CREATE TABLE `userlogins` (
  `LoginProvider` varchar(128) NOT NULL,
  `ProviderKey` varchar(128) NOT NULL,
  `UserId` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `userroles`
--

CREATE TABLE `userroles` (
  `UserId` varchar(128) NOT NULL,
  `RoleId` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `Id` varchar(128) NOT NULL,
  `UserName` varchar(256) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Email` varchar(256) DEFAULT NULL,
  `EmailConfirmed` tinyint(1) NOT NULL,
  `PasswordHash` longtext,
  `SecurityStamp` longtext,
  `PhoneNumber` longtext,
  `PhoneNumberConfirmed` tinyint(1) NOT NULL,
  `TwoFactorEnabled` tinyint(1) NOT NULL,
  `LockoutEndDateUtc` datetime DEFAULT NULL,
  `LockoutEnabled` tinyint(1) NOT NULL,
  `AccessFailedCount` int(11) NOT NULL,
  `sex` text NOT NULL,
  `versityDeptId` int(11) NOT NULL,
  `Address` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `versity`
--

CREATE TABLE `versity` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `versitydept`
--

CREATE TABLE `versitydept` (
  `id` int(11) NOT NULL,
  `versityId` int(11) NOT NULL,
  `deptId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `year`
--

CREATE TABLE `year` (
  `id` int(11) NOT NULL,
  `year` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendence`
--
ALTER TABLE `attendence`
  ADD PRIMARY KEY (`id`),
  ADD KEY `markId` (`markId`),
  ADD KEY `markId_2` (`markId`),
  ADD KEY `markId_3` (`markId`);

--
-- Indexes for table `attendencesection`
--
ALTER TABLE `attendencesection`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacherCourceId` (`teacherCourceId`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`id`),
  ADD KEY `versityDeptId` (`versityDeptId`);

--
-- Indexes for table `degree`
--
ALTER TABLE `degree`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `degreesessionyearterm`
--
ALTER TABLE `degreesessionyearterm`
  ADD PRIMARY KEY (`id`),
  ADD KEY `degreeId` (`degreeId`),
  ADD KEY `sessionId` (`sessionId`),
  ADD KEY `yearId` (`yearId`),
  ADD KEY `termId` (`termId`);

--
-- Indexes for table `dept`
--
ALTER TABLE `dept`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `designation`
--
ALTER TABLE `designation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mark`
--
ALTER TABLE `mark`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mark` (`mark`),
  ADD KEY `marksheetId` (`markSectiontId`),
  ADD KEY `markSectiontId` (`markSectiontId`),
  ADD KEY `studentId` (`studentId`),
  ADD KEY `markSectiontId_2` (`markSectiontId`);

--
-- Indexes for table `marksection`
--
ALTER TABLE `marksection`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sectionPercentage` (`sectionPercentage`),
  ADD KEY `sectionNameId` (`sectionNameId`),
  ADD KEY `teacherCourseId` (`teacherCourseId`),
  ADD KEY `sectionPercentage_2` (`sectionPercentage`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `salutation`
--
ALTER TABLE `salutation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `id_2` (`id`);

--
-- Indexes for table `sectionname`
--
ALTER TABLE `sectionname`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid` (`userid`);

--
-- Indexes for table `studentusercourse`
--
ALTER TABLE `studentusercourse`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`teachercourseid`),
  ADD KEY `stud` (`studentid`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`id`),
  ADD KEY `salutationid` (`salutationid`),
  ADD KEY `designationid` (`designationid`),
  ADD KEY `UserId` (`UserId`);

--
-- Indexes for table `teachercourse`
--
ALTER TABLE `teachercourse`
  ADD PRIMARY KEY (`id`),
  ADD KEY `DegreeSessionYearTermId` (`DegreeSessionYearTermId`),
  ADD KEY `userId` (`teacherId`),
  ADD KEY `courseId` (`courseId`);

--
-- Indexes for table `term`
--
ALTER TABLE `term`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `userclaims`
--
ALTER TABLE `userclaims`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Id` (`Id`),
  ADD KEY `UserId` (`UserId`);

--
-- Indexes for table `userlogins`
--
ALTER TABLE `userlogins`
  ADD PRIMARY KEY (`LoginProvider`,`ProviderKey`,`UserId`),
  ADD KEY `ApplicationUser_Logins` (`UserId`);

--
-- Indexes for table `userroles`
--
ALTER TABLE `userroles`
  ADD PRIMARY KEY (`UserId`,`RoleId`),
  ADD KEY `IdentityRole_Users` (`RoleId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `versityDeptId` (`versityDeptId`);

--
-- Indexes for table `versity`
--
ALTER TABLE `versity`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `versitydept`
--
ALTER TABLE `versitydept`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `versityId_2` (`versityId`,`deptId`),
  ADD KEY `versityId` (`versityId`),
  ADD KEY `deptId` (`deptId`);

--
-- Indexes for table `year`
--
ALTER TABLE `year`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendence`
--
ALTER TABLE `attendence`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=211;
--
-- AUTO_INCREMENT for table `attendencesection`
--
ALTER TABLE `attendencesection`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=194;
--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `degree`
--
ALTER TABLE `degree`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `degreesessionyearterm`
--
ALTER TABLE `degreesessionyearterm`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `dept`
--
ALTER TABLE `dept`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `designation`
--
ALTER TABLE `designation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `mark`
--
ALTER TABLE `mark`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=341;
--
-- AUTO_INCREMENT for table `marksection`
--
ALTER TABLE `marksection`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;
--
-- AUTO_INCREMENT for table `salutation`
--
ALTER TABLE `salutation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `sectionname`
--
ALTER TABLE `sectionname`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `session`
--
ALTER TABLE `session`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `studentusercourse`
--
ALTER TABLE `studentusercourse`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `teacher`
--
ALTER TABLE `teacher`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `teachercourse`
--
ALTER TABLE `teachercourse`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `term`
--
ALTER TABLE `term`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `userclaims`
--
ALTER TABLE `userclaims`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `versity`
--
ALTER TABLE `versity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `versitydept`
--
ALTER TABLE `versitydept`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `year`
--
ALTER TABLE `year`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendence`
--
ALTER TABLE `attendence`
  ADD CONSTRAINT `attendence_ibfk_1` FOREIGN KEY (`markId`) REFERENCES `mark` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `attendencesection`
--
ALTER TABLE `attendencesection`
  ADD CONSTRAINT `attendencesection_ibfk_1` FOREIGN KEY (`teacherCourceId`) REFERENCES `teachercourse` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `course_ibfk_1` FOREIGN KEY (`versityDeptId`) REFERENCES `versitydept` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `degreesessionyearterm`
--
ALTER TABLE `degreesessionyearterm`
  ADD CONSTRAINT `degreesessionyearterm_ibfk_1` FOREIGN KEY (`yearId`) REFERENCES `year` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `degreesessionyearterm_ibfk_2` FOREIGN KEY (`termId`) REFERENCES `term` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `degreesessionyearterm_ibfk_3` FOREIGN KEY (`sessionId`) REFERENCES `session` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `degreesessionyearterm_ibfk_4` FOREIGN KEY (`degreeId`) REFERENCES `degree` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mark`
--
ALTER TABLE `mark`
  ADD CONSTRAINT `mark_ibfk_2` FOREIGN KEY (`studentId`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mark_ibfk_3` FOREIGN KEY (`markSectiontId`) REFERENCES `marksection` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `marksection`
--
ALTER TABLE `marksection`
  ADD CONSTRAINT `marksection_ibfk_2` FOREIGN KEY (`sectionNameId`) REFERENCES `sectionname` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `marksection_ibfk_3` FOREIGN KEY (`teacherCourseId`) REFERENCES `teachercourse` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `student_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `studentusercourse`
--
ALTER TABLE `studentusercourse`
  ADD CONSTRAINT `studentusercourse_ibfk_1` FOREIGN KEY (`studentid`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `studentusercourse_ibfk_2` FOREIGN KEY (`teachercourseid`) REFERENCES `teachercourse` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `teacher`
--
ALTER TABLE `teacher`
  ADD CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`salutationid`) REFERENCES `salutation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `teacher_ibfk_2` FOREIGN KEY (`designationid`) REFERENCES `designation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `teacher_ibfk_3` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `teachercourse`
--
ALTER TABLE `teachercourse`
  ADD CONSTRAINT `teachercourse_ibfk_1` FOREIGN KEY (`DegreeSessionYearTermId`) REFERENCES `degreesessionyearterm` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `teachercourse_ibfk_2` FOREIGN KEY (`courseId`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `teachercourse_ibfk_3` FOREIGN KEY (`teacherId`) REFERENCES `teacher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `userclaims`
--
ALTER TABLE `userclaims`
  ADD CONSTRAINT `ApplicationUser_Claims` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `userlogins`
--
ALTER TABLE `userlogins`
  ADD CONSTRAINT `ApplicationUser_Logins` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `userroles`
--
ALTER TABLE `userroles`
  ADD CONSTRAINT `ApplicationUser_Roles` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `IdentityRole_Users` FOREIGN KEY (`RoleId`) REFERENCES `roles` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`versityDeptId`) REFERENCES `versitydept` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `versitydept`
--
ALTER TABLE `versitydept`
  ADD CONSTRAINT `versitydept_ibfk_1` FOREIGN KEY (`versityId`) REFERENCES `versity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `versitydept_ibfk_2` FOREIGN KEY (`deptId`) REFERENCES `dept` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
